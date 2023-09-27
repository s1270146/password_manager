import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pass_manager/model/user_model.dart';

final loginUserProvider =
    StateProvider.autoDispose.family<Future<UserModel>, String>((ref, id) {
  return Future.delayed(const Duration(seconds: 1)).then(
    (value) => UserModel(
      id: id,
      name: "test",
      email: "test@gmail",
    ),
  );
});
