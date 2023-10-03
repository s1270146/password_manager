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

  factory UserModel.fromJson(dynamic data) {
    try {
      final map = data as Map<String, dynamic>;
      return UserModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
      );
    } on Exception catch (e) {
      print(e);
      rethrow;
    } on Error catch (err) {
      print(err);
      rethrow;
    }
  }

  String getId() {
    return _id;
  }
}
