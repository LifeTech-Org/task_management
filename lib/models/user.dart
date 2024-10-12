class User {
  const User(
      {this.firstName,
      this.lastName,
      this.dob,
      this.country,
      required this.uid});
  final String? firstName;
  final String? lastName;
  final DateTime? dob;
  final String? country;
  final String uid;
}
