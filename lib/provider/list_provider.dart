import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pass_manager/model/message_model.dart';
import 'package:pass_manager/model/password_model.dart';
import 'package:pass_manager/provider/model_provider.dart';
import 'package:pass_manager/provider/supabase_provider.dart';

final passwordListProvider = FutureProvider.autoDispose
    .family<PasswordListModel, String>((ref, id) async {
  final supabase = ref.watch(supabaseProvider);
  final user = await ref.watch(loginUserProvider(id));
  final encrypter = ref.watch(encrypterProvider);
  final unreadMessageExists = await ref.watch(unreadMessageCountProvider(id));
  final List<PasswordModel> passwordList = await supabase
      .from('password')
      .select()
      .eq('uid', user.getId())
      .order('created_at')
      .then((getList) {
    List<PasswordModel> passwordList = [];
    getList = getList as List;
    for (var data in getList) {
      passwordList.add(PasswordModel.fromJson(data, encrypter!));
    }
    return passwordList;
  });
  return PasswordListModel(
    user: user,
    unreadMessageExists: unreadMessageExists,
    passwordList: passwordList,
  );
});

final unreadMessageCountProvider =
    StateProvider.family<Future<bool>, String>((ref, id) async {
  final supabase = ref.watch(supabaseProvider);
  final messageList = await supabase
      .from('message')
      .select('id')
      .eq('to_uid', id)
      .eq('unread', true) as List;
  return messageList.isNotEmpty;
});

final messageListProvider =
    FutureProvider.family<List<MessageModel>, String>((ref, id) async {
  final supabase = ref.watch(supabaseProvider);
  return await supabase
      .from('message')
      .select()
      .eq('to_uid', id)
      .order('created_at')
      .then((getList) {
    List<MessageModel> messageList = [];
    getList = getList as List;
    for (var data in getList) {
      messageList.add(MessageModel.fromJson(data));
    }
    return messageList;
  });
});
