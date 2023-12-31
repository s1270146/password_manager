import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pass_manager/component/app_bar/customized_app_bar.dart';
import 'package:pass_manager/provider/list_provider.dart';
import 'package:pass_manager/provider/supabase_provider.dart';

class PasswordListScreen extends ConsumerWidget {
  const PasswordListScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getData = ref.watch(passwordListProvider(uid));
    final supabase = ref.watch(supabaseProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 63, 0, 113),
      appBar: CustomizedAppBar(
        automaticallyImplyLeading: false,
        title: "Password List",
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(unreadMessageCountProvider);
              ref.invalidate(passwordListProvider);
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Center(
        child: getData.when(
          data: (data) {
            return Column(
              children: [
                data.viewPasswordList(),
              ],
            );
          },
          error: (err, stack) {
            return Text("Error: $err");
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Visibility(
        visible: getData.hasValue,
        child: getData.when(
          data: (data) =>
              data.floatingActionButton(context, supabase.auth, ref),
          error: (err, stack) => const FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.close),
          ),
          loading: () => const FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.close),
          ),
        ),
      ),
    );
  }
}
