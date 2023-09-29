import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pass_manager/component/app_bar/customized_app_bar.dart';
import 'package:pass_manager/provider/list_provider.dart';

class MessageListScreen extends ConsumerWidget {
  const MessageListScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageList = ref.watch(messageListProvider(uid));
    return Scaffold(
      appBar: CustomizedAppBar(title: "Messages"),
      body: Center(
        child: messageList.when(
          data: (data) => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => Center(
                    child: data[index].showHeadline(context, 300, 80),
                  ),
                ),
              ),
            ],
          ),
          error: (err, stack) => Text("Error: $err"),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
