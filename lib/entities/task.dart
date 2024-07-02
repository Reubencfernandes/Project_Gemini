import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id? id;
  String title;
  String description;
  String category;
  DateTime startTime;
  DateTime endTime;

  Task({
    this.id = Isar.autoIncrement,
    required this.title,
    required this.description,
    required this.category,
    required this.startTime,
    required this.endTime,
  });
}
