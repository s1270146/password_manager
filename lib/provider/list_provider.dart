import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pass_manager/model/message_model.dart';
import 'package:pass_manager/model/password_model.dart';
import 'package:pass_manager/provider/model_provider.dart';

final passwordListProvider = FutureProvider.autoDispose
    .family<PasswordListModel, String>((ref, id) async {
  final user = await ref.watch(loginUserProvider(id));
  return PasswordListModel(
    user: user,
    unreadMessageExists: true,
    passwordList: [
      PasswordModel(
        id: id,
        name: "name_test1",
        password: "key_test1",
        uid: "key_id_test1",
        isShared: false,
        createdAt: DateTime.now(),
      ),
      PasswordModel(
        id: id,
        name: "name_test2",
        password: "key_test2",
        uid: "key_id_test2",
        isShared: false,
        createdAt: DateTime.now(),
      ),
      PasswordModel(
        id: id,
        name: "name_test3",
        password: "key_test3",
        uid: "key_id_test3",
        isShared: false,
        createdAt: DateTime.now(),
      ),
    ],
  );
});

final messageListProvider =
    FutureProvider.autoDispose.family<List<MessageModel>, String>((ref, id) {
  return Future.delayed(const Duration(seconds: 1)).then((_) => [
        MessageModel(
          title: "test_title1",
          mainText: "test_main",
          fromUid: "test_fromuid",
          toUid: "test_toUid",
          unread: true,
          createAt: DateTime.now(),
        ),
        MessageModel(
          title: "test_title2",
          mainText: "test_main",
          fromUid: "test_fromuid",
          toUid: "test_toUid",
          unread: true,
          createAt: DateTime.now(),
        ),
        MessageModel(
          title: "test_title3",
          mainText: "test_main",
          fromUid: "test_fromuid",
          toUid: "test_toUid",
          unread: false,
          createAt: DateTime.now(),
        ),
        MessageModel(
          title: "test_title4",
          mainText: "test_main",
          fromUid: "test_fromuid",
          toUid: "test_toUid",
          unread: false,
          createAt: DateTime.now(),
        ),
      ]);
});
