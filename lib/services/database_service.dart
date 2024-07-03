import 'package:ayumi/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService extends ChangeNotifier {
  static final DatabaseService _singleton = DatabaseService._internal();

  factory DatabaseService() {
    return _singleton;
  }

  DatabaseService._internal();

  // Members
  static late final Isar _isar;

  Isar get isar => _isar;
  final List<Task> tasks = [];

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([TaskSchema], directory: documentsDirectory.path);
  }

  // Task functions
  // CRUD
  Future<List<Task>> _getTasks() async {
    // get the time as 00:00 and 23:59 to use in filter
    DateTime startOfDay = DateTime(
      DateTime
          .now()
          .year,
      DateTime
          .now()
          .month,
      DateTime
          .now()
          .day,
    );
    DateTime endOfDay = DateTime(
      DateTime
          .now()
          .year,
      DateTime
          .now()
          .month,
      DateTime
          .now()
          .day + 1,
    );

    return await _isar.tasks
        .filter()
        .startTimeBetween(startOfDay, endOfDay)
        .findAll();
  }

  Future readTasks() async {
    tasks.clear();
    tasks.addAll(await _getTasks());
    notifyListeners();
  }

  Future addTask(Task newTask) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.put(newTask);
    });
    readTasks();
  }

  Future editTask(Task editedTask) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.put(editedTask);
    });
    readTasks();
  }

  Future deleteTask(int id) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.delete(id);
    });
    readTasks();
  }

  Task? getCurrentTask() {
    return _isar.tasks
        .filter()
        .startTimeLessThan(DateTime.now())
        .endTimeGreaterThan(DateTime.now())
        .findFirstSync();
  }

}