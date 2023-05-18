// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:advancedtodo/controllers/task_controller.dart';
import 'package:advancedtodo/models/task.dart';
import 'package:advancedtodo/ui/theme.dart';
import 'package:advancedtodo/ui/widgets/button.dart';
import 'package:advancedtodo/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "11:59 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now().toLocal());
  int _selectRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
    30,
  ];
  String _selectRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              MyInputField(
                title: "Title",
                hint: "Enter your title",
                controller: _titleController,
              ),
              MyInputField(
                title: "Note",
                hint: "Enter your note",
                controller: _noteController,
              ),
              MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: MyInputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(
                title: "Remind",
                hint: "$_selectRemind minutes early",
                widget: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: DropdownButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      underline: Container(height: 0),
                      items:
                          remindList.map<DropdownMenuItem<String>>((int value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectRemind = int.parse(newValue!);
                        });
                      },
                    ),
                  ),
                ),
              ),
              MyInputField(
                title: "Repeat",
                hint: _selectRepeat,
                widget: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: DropdownButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      underline: Container(height: 0),
                      items: repeatList
                          .map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectRepeat = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPallete(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: MyButton(
                      label: "Create Task",
                      onTap: () {
                        _validateData();
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Get.isDarkMode ? Colors.white : Colors.black,
          size: 25,
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

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2013),
      lastDate: DateTime(2123),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {}
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    // ignore: use_build_context_synchronously
    String _formatedTime = pickedTime.format(context);

    if (pickedTime == null) {
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() async {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        // _startTime --> 10:30 AM
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? blue
                      : index == 1
                          ? pink
                          : yellow,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task:Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectRemind,
        repeat: _selectRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are required!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.red,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    }
  }
}
