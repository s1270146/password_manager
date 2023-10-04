import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pass_manager/provider/list_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageModel {
  final int _id;
  final String _title;
  final String _mainText;
  final String _fromUid;
  final String _toUid;
  final bool _unread;
  final DateTime _createdAt;

  MessageModel({
    required int id,
    required String title,
    required String mainText,
    required String fromUid,
    required String toUid,
    required bool unread,
    required DateTime createdAt,
  })  : _id = id,
        _title = title,
        _mainText = mainText,
        _fromUid = fromUid,
        _toUid = toUid,
        _unread = unread,
        _createdAt = createdAt;

  factory MessageModel.fromJson(dynamic data) {
    try {
      final map = data as Map<String, dynamic>;
      return MessageModel(
        id: map['id'],
        title: map['title'],
        mainText: map['main_text'],
        fromUid: map['from_uid'],
        toUid: map['to_uid'],
        unread: map['unread'],
        createdAt: DateTime.parse(map['created_at']),
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  String getDisplayCreateAt() {
    return DateFormat('yyyy年MM月dd日 hh:mm').format(_createdAt);
  }

  Widget showHeadline(BuildContext context, double width, double height,
      SupabaseClient supabase, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              width: width,
              height: 500,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(
                      Icons.close,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(_title),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Text("From: $_fromUid"),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: const Text("Message: "),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(_mainText),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        if (_unread) {
          await supabase.from("message").update(
            {'unread': false},
          ).eq("id", _id);
          ref.invalidate(messageListProvider);
          ref.invalidate(unreadMessageCountProvider);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
        ),
        width: width,
        height: height,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(5),
              child: Text(
                getDisplayCreateAt(),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(5),
              child: Text(
                _title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.all(5),
              child: Visibility(
                visible: _unread,
                child: const Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
