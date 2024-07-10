

import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id? id;
  String title;
  String description;
  String category;
  String day;
  DateTime startTime;
  DateTime endTime;

  Task({
    this.id = Isar.autoIncrement,
    required this.title,
    required this.description,
    required this.category,
    required this.day,
    required this.startTime,
    required this.endTime,
  });
}
