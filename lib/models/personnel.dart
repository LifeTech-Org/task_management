class Personnel {
  const Personnel(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.role});
  final String id;
  final String name;
  final String phoneNumber;
  final String role;

  factory Personnel.fromJson(dynamic json) {
    return Personnel(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        role: json['role']);
  }
}
