class Personnel {
  const Personnel(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.role,
      required this.userId});
  final String id;
  final String name;
  final String phoneNumber;
  final String role;
  final String userId;

  factory Personnel.fromJson(dynamic json) {
    return Personnel(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        role: json['role'],
        userId: json['userId']);
  }
}
