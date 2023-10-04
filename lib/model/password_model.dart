import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pass_manager/component/dialog/customized_alert_dialog.dart';
import 'package:pass_manager/component/list_tile/password_view_box.dart';
import 'package:pass_manager/model/user_model.dart';
import 'package:pass_manager/provider/list_provider.dart';
import 'package:pass_manager/screen/message_list_screen.dart';
import 'package:pass_manager/screen/password_registration_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@immutable
class PasswordModel {
  final int _id;
  final String _name;
  final String _password;
  final String _uid;
  final bool _isShared;
  final IV _iv;
  final DateTime _createdAt;
  const PasswordModel({
    required int id,
    required String name,
    required String password,
    required String uid,
    required bool isShared,
    required DateTime createdAt,
    required IV iv,
  })  : _createdAt = createdAt,
        _isShared = isShared,
        _uid = uid,
        _name = name,
        _id = id,
        _password = password,
        _iv = iv;
  factory PasswordModel.fromJson(dynamic data, Encrypter encrypter) {
    try {
      final map = data as Map<String, dynamic>;
      final decrypt = encrypter.decrypt(
        Encrypted.fromBase64(map['password'].toString()),
        iv: IV.fromBase64(map['iv'].toString()),
      );
      return PasswordModel(
        id: map['id'],
        name: map['name'],
        password: decrypt,
        uid: map['uid'],
        isShared: map['is_shared'],
        createdAt: DateTime.parse(
          map['created_at'],
        ),
        iv: IV.fromBase64(map['iv']),
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Widget view(final double width, final double height) {
    return PasswordViewBox(
      id: _id.toString(),
      uid: _uid,
      name: _name,
      password: _password,
      width: width,
      height: height,
      textSize: 20,
    );
  }
}

class PasswordListModel {
  final UserModel user;
  final List<PasswordModel> passwordList;
  final bool unreadMessageExists;
  const PasswordListModel({
    required this.user,
    required this.passwordList,
    required this.unreadMessageExists,
  });

  Widget viewPasswordList() {
    return Expanded(
      child: ListView.builder(
        itemCount: passwordList.length,
        itemBuilder: (context, index) {
          return Center(
            child: passwordList[index].view(300, 80),
          );
        },
      ),
    );
  }

  Widget floatingActionButton(
      BuildContext context, GoTrueClient auth, WidgetRef ref) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SpeedDial(
              icon: Icons.menu,
              activeIcon: Icons.close,
              children: [
                SpeedDialChild(
                  child: const Icon(Icons.logout),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  label: 'Log Out',
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => CustomizedAlertDialog(
                      title: 'Log out?',
                      onPressedOfPossitive: () {
                        auth.signOut();
                        int i = 0;
                        Navigator.popUntil(context, (_) => i++ >= 2);
                      },
                      onPressedOfNegative: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.add),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  label: 'Add New Password',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PasswordRegistrationScreen.firstRegister(
                        uid: user.getId(),
                      ),
                    ),
                  ),
                ),
                SpeedDialChild(
                  child: unreadMessageExists
                      ? const Icon(Icons.notifications_active)
                      : const Icon(Icons.message),
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  label: 'Messages',
                  onTap: () {
                    ref.invalidate(messageListProvider);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MessageListScreen(
                          uid: user.getId(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible: unreadMessageExists,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.all(5),
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
