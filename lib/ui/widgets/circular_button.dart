import 'package:advancedtodo/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircularButton extends StatelessWidget {
  final Function()? onTap;

  const CircularButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: IconButton(
          icon: Icon(
            Icons.add_circle,
            size: 50,
            color: Get.isDarkMode ? Colors.white : blue,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
