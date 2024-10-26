import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/models/personnel.dart';

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.date,
    required this.personnelsId,
    required this.isMarkedDone,
  });
  final String id;
  final String title;
  final DateTime start;
  final DateTime end;
  final DateTime date;
  final List<String> personnelsId;
  final bool isMarkedDone;

  factory Task.fromJson(Map<String, dynamic> json) {
    final date = json['date'] as Timestamp;
    final start = json['start'] as Timestamp;
    final end = json['end'] as Timestamp;
    List<dynamic> personnelsId = json['personnelsId'];
    return Task(
        id: json['id'],
        title: json['title'],
        date: date.toDate(),
        start: start.toDate(),
        end: end.toDate(),
        personnelsId: personnelsId.map((id) => id.toString()).toList(),
        isMarkedDone: json['isMarkedDone']);
  }
}

String formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}

String formatTime(DateTime date) {
  return '${date.hour}:${date.minute}';
}


// DateTime mapToDateTime(dynamic map) {
//   return Timestamp(map['_seconds'], map['_nanoseconds']).toDate();
// }

// DateTime stringToDateTime({required DateTime date, required String time}) {
//   final List<String> split = time.split(":");
//   final hours = int.parse(split.first);
//   final minutes = int.parse(split.last);
//   return DateTime(date.year, date.month, date.day, hours, minutes);
// }
