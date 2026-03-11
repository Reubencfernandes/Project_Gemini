import 'package:ayumi/entities/task.dart';
import 'package:ayumi/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService extends ChangeNotifier {
  static final DatabaseService _singleton = DatabaseService._internal();

  factory DatabaseService() => _singleton;

  DatabaseService._internal();

  static Database? _db;
  final List<Task> tasks = [];
  final List<User> users = [];

  Future<Database> get _database async {
    _db ??= await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'ayumi.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            category TEXT NOT NULL,
            day TEXT NOT NULL,
            startTime INTEGER NOT NULL,
            endTime INTEGER NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            birthday TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> init() async {
    await _database;
  }

  Future<List<Task>> getTasksForDate(String day) async {
    final db = await _database;
    final maps = await db.query('tasks', where: 'day = ?', whereArgs: [day]);
    return maps.map(Task.fromMap).toList();
  }

  Future<List<Task>> _getTasks() async {
    final day = DateFormat('dd MMMM yyyy').format(DateTime.now());
    return getTasksForDate(day);
  }

  Future<void> deleteAllTasksForDate(String day) async {
    final db = await _database;
    await db.delete('tasks', where: 'day = ?', whereArgs: [day]);
    notifyListeners();
  }

  Future<void> readTasks() async {
    tasks.clear();
    tasks.addAll(await _getTasks());
    notifyListeners();
  }

  Future<void> addTask(Task newTask) async {
    final db = await _database;
    await db.insert('tasks', newTask.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    readTasks();
  }

  Future<void> editTask(Task editedTask) async {
    final db = await _database;
    await db.update('tasks', editedTask.toMap(),
        where: 'id = ?', whereArgs: [editedTask.id]);
    readTasks();
  }

  Future<void> deleteTask(int id) async {
    final db = await _database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    readTasks();
  }

  Future<Task?> getCurrentTask() async {
    final db = await _database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final maps = await db.query(
      'tasks',
      where: 'startTime <= ? AND endTime >= ?',
      whereArgs: [now, now],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return Task.fromMap(maps.first);
  }

  Future<void> addUser(User newUser) async {
    final db = await _database;
    await db.insert('users', newUser.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await readUsers();
  }

  Future<void> readUsers() async {
    final db = await _database;
    final maps = await db.query('users');
    users.clear();
    users.addAll(maps.map(User.fromMap));
    notifyListeners();
  }

  Future<void> deleteUser(int id) async {
    final db = await _database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
    await readUsers();
  }

  Future<void> wipeEverything() async {
    final db = await _database;
    await db.delete('tasks');
    await db.delete('users');
    tasks.clear();
    users.clear();
    notifyListeners();
  }
}
