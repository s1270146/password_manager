import 'package:flutter/material.dart';

class UserModel {
  final String _id;
  final String _name;
  final String _email;
  UserModel({
    required String id,
    required String name,
    required String email,
  })  : _email = email,
        _name = name,
        _id = id;

  Widget showProfile() {
    return Column(
      children: [
        Text(_id),
        Text(_name),
        Text(_email),
      ],
    );
  }

  String getId() {
    return _id;
  }
}
