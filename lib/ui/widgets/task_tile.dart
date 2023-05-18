// ignore_for_file: avoid_unnecessary_containers

import 'package:advancedtodo/controllers/task_controller.dart';
import 'package:advancedtodo/models/task.dart';
import 'package:advancedtodo/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatelessWidget {
  final Task? task;
  TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            const SizedBox(
              width: 10,
            ),
            SlidableAction(
              onPressed: (context) {
                _deleteTask(context, task!);
              },
              borderRadius: BorderRadius.circular(15),
              backgroundColor: const Color.fromARGB(255, 227, 75, 65),
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
            const SizedBox(
              width: 10,
            ),
            SlidableAction(
              onPressed: (context) {
                if (task!.isCompleted == 0) {
                  task!.isCompleted = 1;
                  print(task!.isCompleted);
                  print("color GREY, text COMPLETED, icon UNDO");
                  _markTaskCompleted(context, task!);
                } else {
                  task!.isCompleted = 0;
                  print(task!.isCompleted);
                  print("color TASKCOLOR, text TODO, icon CHECK");
                }
              },
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Get.isDarkMode
                  ? Colors.grey
                  : const Color.fromARGB(255, 107, 106, 106),
              foregroundColor: Get.isDarkMode ? Colors.white : Colors.white,
              icon: task!.isCompleted == 0
                  ? Icons.check_circle
                  : task!.isCompleted == 1
                      ? Icons.undo_outlined
                      : Icons.error_outline,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          //  width: SizeConfig.screenWidth * 0.78,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: task!.isCompleted == 0
                ? _getBGClr(task?.color ?? 0)
                : task!.isCompleted == 1
                    ? Colors.grey
                    : Colors.deepOrange,
          ),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task?.title ?? "",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${task!.startTime} - ${task!.endTime}",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[100],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    child: Text(
                      task?.note ?? "",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[100],
                        ),
                      ),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task!.isCompleted == 0
                    ? "TODO"
                    : task!.isCompleted == 1
                        ? "COMPLETED"
                        : "ERROR",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return blue;
      case 1:
        return pink;
      case 2:
        return yellow;
      default:
        return blue;
    }
  }
}

_markTaskCompleted(BuildContext context, Task task) {
  final taskController = Get.put(TaskController());
  taskController.markTaskCompleted(task.id!);
}

_deleteTask(BuildContext context, Task task) {
  final taskController = Get.put(TaskController());
  taskController.delete(task);
}
