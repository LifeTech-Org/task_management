import 'package:task_management/models/personnel.dart';

class Team {
  const Team({
    required this.name,
    required this.description,
    required this.personnels,
  });
  final String name;
  final DateTime description;
  final List<Personnel> personnels;
}
