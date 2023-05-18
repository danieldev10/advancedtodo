// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print
import 'package:advancedtodo/controllers/task_controller.dart';
import 'package:advancedtodo/ui/add_task_bar.dart';
import 'package:advancedtodo/ui/theme.dart';
import 'package:advancedtodo/ui/widgets/circular_button.dart';
import 'package:advancedtodo/ui/widgets/task_tile.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';
import '../services/notification_services.dart';
import 'package:advancedtodo/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper = NotifyHelper();
  final _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          _addTaskBar(),
          // DATE BAR
          Container(
            margin: const EdgeInsets.only(top: 17, left: 13),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: blue,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              dayTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              monthTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
          ),
          // DATE BAR END

          const SizedBox(height: 20),

          // LIST OF TODOS
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: _taskController.taskList.length,
                itemBuilder: (_, index) {
                  Task task = _taskController.taskList[index];
                  if (task.repeat == 'Daily' ||
                      task.date == DateFormat.yMd().format(_selectedDate)) {
                    DateTime date =
                        DateFormat.jm().parse(task.startTime.toString());
                    var myTime = DateFormat("HH:mm").format(date);
                    notifyHelper.scheduledNotification(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      task,
                    );
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                child: TaskTile(task),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (task.date == DateFormat.yMd().format(_selectedDate)) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {

                                },
                                child: TaskTile(task),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            }),
          ),
          // END LIST OF TODOS
        ],
      ),
    );
  }
}

_addTaskBar() {
  final _taskController = Get.put(TaskController());
  return Container(
    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMd().format(DateTime.now()),
              style: subHeadingStyle,
            ),
            Text(
              "Today",
              style: headingStyle,
            ),
          ],
        ),
        CircularButton(
          onTap: () async {
            await Get.to(() => const AddTaskPage());
            _taskController.getTasks();
          },
        ),
      ],
    ),
  );
}

_appBar(BuildContext context) {
  // var notifyHelper = NotifyHelper();
  return AppBar(
    backgroundColor: context.theme.backgroundColor,
    elevation: 0,
    leading: GestureDetector(
      onTap: () {
        ThemeServices().switchTheme();
        // notifyHelper.displayNotification(
        //   title: "Theme Changed",
        //   body:
        //       Get.isDarkMode ? "Activated Light Theme" : "Activated Dark Theme",
        // );
        // notifyHelper.scheduledNotification();
      },
      child: Icon(
        Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
        size: 25,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
    ),
    actions: const [
      CircleAvatar(
        backgroundImage: AssetImage("images/avatar.jpeg"),
      ),
      SizedBox(
        width: 20,
      ),
    ],
  );
}

// _bottomSheetButton({
//   required String label,
//   required Function()? onTap,
//   required Color clr,
//   bool isClose = false,
//   required BuildContext context,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       height: 55,
//       width: MediaQuery.of(context).size.width * 0.9,
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 2,
//           color: isClose == true
//               ? Get.isDarkMode
//                   ? Colors.grey[600]!
//                   : Colors.grey[300]!
//               : clr,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         color: isClose == true ? Colors.transparent : clr,
//       ),
//       child: Center(
//         child: Text(
//           label,
//           style:
//               isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
//         ),
//       ),
//     ),
//   );
// }
