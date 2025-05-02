import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  Database? _db;

  List<Task> get tasks => _tasks;

  TaskProvider() {
    initDB();
  }

  Future<void> initDB() async {
    String path = join(await getDatabasesPath(), 'task.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status TEXT, dueDate TEXT)',
        );
      },
    );
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final data = await _db!.query('tasks');
    _tasks = data.map((e) => Task.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _db!.insert('tasks', task.toMap());
    fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await _db!.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await _db!.delete('tasks', where: 'id = ?', whereArgs: [id]);
    fetchTasks();
  }
}
