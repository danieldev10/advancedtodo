// ignore_for_file: unnecessary_new, avoid_print

import 'package:advancedtodo/db/db_settings.dart';
import 'package:get/get.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBSettings.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBSettings.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBSettings.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DBSettings.update(id);
    getTasks();
  }
}
