// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.grey,
          ),
        ),
        title: Text(
          this.label.toString().split("|")[0],
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode ? Colors.grey[800] : Colors.grey[300],
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              this.label.toString().split("|")[1],
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
