import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageModel {
  final String _title;
  final String _mainText;
  final String _fromUid;
  final String _toUid;
  final bool _unread;
  final DateTime _createAt;

  MessageModel({
    required String title,
    required String mainText,
    required String fromUid,
    required String toUid,
    required bool unread,
    required DateTime createAt,
  })  : _title = title,
        _mainText = mainText,
        _fromUid = fromUid,
        _toUid = toUid,
        _unread = unread,
        _createAt = createAt;

  String getDisplayCreateAt() {
    return DateFormat('yyyy年MM月dd日 hh:mm').format(_createAt);
  }

  Widget showHeadline(BuildContext context, double width, double height) {
    return GestureDetector(
      onTap: () => showDialog<void>(
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
      ),
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
