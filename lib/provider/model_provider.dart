import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pass_manager/model/user_model.dart';
import 'package:pass_manager/provider/supabase_provider.dart';

final loginUserProvider =
    StateProvider.autoDispose.family<Future<UserModel>, String>(
  (ref, id) async {
    final supabase = ref.watch(supabaseProvider);
    return await supabase.from('user').select().eq('id', id).then(
          (value) => UserModel.fromJson(value[0]),
        );
  },
);
