import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color blue = Color(0xFF4E5AE8);
const Color yellow = Color(0xFFFFB746);
const Color pink = Color(0xFFFF4667);
const Color white = Colors.white;
const Color darkGrey = Color(0xFF121212);
Color darkHeader = const Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primarySwatch: Colors.primaryBlack,
    primaryColor: Colors.white,
    backgroundColor: Colors.white,
    brightness: Brightness.light
  );

  static final dark = ThemeData(
    primarySwatch: Colors.primaryBlack,
    backgroundColor: const Color.fromARGB(255, 50, 49, 49),
    primaryColor: Colors.black,
    brightness: Brightness.dark
  );
}


TextStyle get subHeadingStyle {
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato (
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato (
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode?Colors.grey[100]:Colors.grey[900],
    ),
  );
}