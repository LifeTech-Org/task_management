import 'package:task_management/models/personnel.dart';

class Team {
  const Team({
    required this.name,
    required this.description,
    required this.personnels,
  });
  final String name;
  final String description;
  final List<Personnel> personnels;

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['name'],
      description: json['description'],
      personnels: [],
    );
  }
}
