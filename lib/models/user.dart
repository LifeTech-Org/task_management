class UserData {
  const UserData(
      {required this.id,
      required this.name,
      this.city,
      this.country,
      this.phoneNumber,
      this.photoUrl});
  final String id;
  final String name;
  final String? phoneNumber;
  final String? country;
  final String? city;
  final String? photoUrl;

  factory UserData.fromJson(dynamic json) {
    return UserData(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        country: json['country'],
        city: json['city'],
        photoUrl: json['photoUrl']);
  }
}
