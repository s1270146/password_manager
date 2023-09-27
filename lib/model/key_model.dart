class KeyModel {
  final String id;
  final String name;
  final String key;
  final String uid;
  final bool isShared;
  final DateTime createdAt;
  KeyModel({
    required this.id,
    required this.name,
    required this.key,
    required this.uid,
    required this.isShared,
    required this.createdAt,
  });
}
