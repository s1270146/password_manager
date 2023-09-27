import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pass_manager/provider/model_provider.dart';

final keyListProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, id) async {
  final user = await ref.watch(loginUserProvider(id));
  return {
    "user": user.name,
  };
});
