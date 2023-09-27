import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pass_manager/provider/list_provider.dart';

class KeyListScreen extends ConsumerWidget {
  const KeyListScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getData = ref.watch(keyListProvider(uid));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Key List"),
      ),
      body: Center(
        child: getData.when(
          data: (data) {
            return Column(
              children: [Text(data["user"])],
            );
          },
          error: (err, stack) {
            return Text("Error: $err");
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
