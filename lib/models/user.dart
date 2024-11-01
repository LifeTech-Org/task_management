class UserData {
  const UserData({required this.id, required this.name, required this.uid});
  final String id;
  final String name;
  final String uid;

  factory UserData.fromJson(dynamic json) {
    return UserData(id: json['id'], name: json['name'], uid: json['uid']);
  }
}
