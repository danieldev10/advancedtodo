// ignore_for_file: prefer_const_declarations, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, avoid_print

import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBSettings {
  static Database? _db;
  static final int _version = 1;
  static final String _tableNameTask = "tasks";
  // static final String _tableNameRecover = "recover";

  static Future<void> initDb() async {
    String taskTable = "CREATE TABLE $_tableNameTask("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "title STRING, note TEXT, date STRING, "
        "startTime STRING, endTime STRING, "
        "remind INTEGER, repeat STRING, "
        "color INTEGER, "
        "isCompleted INTEGER)";

    // String recoverTaskTable = "CREATE TABLE $_tableNameRecover("
    //     "id INTEGER PRIMARY KEY AUTOINCREMENT, "
    //     "title STRING, note TEXT, date STRING, "
    //     "startTime STRING, endTime STRING, "
    //     "remind INTEGER, repeat STRING, "
    //     "color INTEGER, "
    //     "isCompleted INTEGER)";

    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("Creating a new one");
          // db.execute(recoverTaskTable);
          return db.execute(taskTable);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    return await _db?.insert(_tableNameTask, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _db!.query(_tableNameTask);
  }

  static delete(Task task) async {
    return await _db!
        .delete(_tableNameTask, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id = ?
    ''', [1, id]);
  }
}
