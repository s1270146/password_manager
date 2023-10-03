import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pass_manager/component/list_tile/password_view_box.dart';
import 'package:pass_manager/model/user_model.dart';
import 'package:pass_manager/screen/message_list_screen.dart';
import 'package:pass_manager/screen/password_registration_screen.dart';

@immutable
class PasswordModel {
  final int _id;
  final String _name;
  final String _password;
  final String _uid;
  final bool _isShared;
  final DateTime _createdAt;
  const PasswordModel({
    required int id,
    required String name,
    required String password,
    required String uid,
    required bool isShared,
    required DateTime createdAt,
  })  : _createdAt = createdAt,
        _isShared = isShared,
        _uid = uid,
        _name = name,
        _id = id,
        _password = password;
  factory PasswordModel.fromJson(dynamic data) {
    try {
      final map = data as Map<String, dynamic>;
      return PasswordModel(
        id: map['id'],
        name: map['name'],
        password: map['password'],
        uid: map['uid'],
        isShared: map['is_shared'],
        createdAt: DateTime.parse(
          map['created_at'],
        ),
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

  Widget floatingActionButton(BuildContext context) {
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
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MessageListScreen(
                        uid: user.getId(),
                      ),
                    ),
                  ),
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
