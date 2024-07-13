import 'package:ayumi/entities/task.dart';
import 'package:ayumi/entities/user.dart';
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
  final List<User> users = [];

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([TaskSchema, UserSchema], directory: documentsDirectory.path);
  }

  // Task functions
  // CRUD
  Future<List<Task>> _getTasks() async {
    // get the time as 00:00 and 23:59 to use in filter
    DateTime startOfDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    DateTime endOfDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
    );

    return await _isar.tasks
        .filter()
        .startTimeBetween(startOfDay, endOfDay)
        .findAll();
  }

  Future<void> readTasks() async {
    tasks.clear();
    tasks.addAll(await _getTasks());
    notifyListeners();
  }

  Future<void> addTask(Task newTask) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.put(newTask);
    });
    readTasks();
  }

  Future<void> editTask(Task editedTask) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.put(editedTask);
    });
    readTasks();
  }

  Future<void> deleteTask(int id) async {
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

  // User functions
  Future<void> addUser(User newUser) async {
    await _isar.writeTxn(() async {
      await _isar.users.put(newUser);
    });
    readUsers();
  }

  Future<void> readUsers() async {
    users.clear();
    users.addAll(await _isar.users.where().findAll());
    notifyListeners();
  }

  Future<void> deleteUser(int id) async {
    await _isar.writeTxn(() async {
      await _isar.users.delete(id);
    });
    readUsers();
  }
  Future<void> wipeEverything() async{
    await _isar.writeTxn(() async{
      await _isar.clear();
    });
  }
}
