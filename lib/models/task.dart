import 'package:task_management/models/personnel.dart';

class Task {
  const Task({
    required this.title,
    required this.start,
    required this.end,
    required this.date,
    required this.personnels,
    required this.teamId,
  });
  final String title;
  final DateTime start;
  final DateTime end;
  final DateTime date;
  final List<Personnel> personnels;
  final String teamId;

  // factory Task.fromJson(Map<String, dynamic> json) {
  //   return Task(
  //       title: json['title'],
  //       start: json['start'],
  //       end: json['end'],
  //       date: json['date']);
  // }
}
