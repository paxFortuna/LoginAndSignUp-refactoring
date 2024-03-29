import 'package:flutter/material.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFffB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = const Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    // backgroundColor: Colors.white,
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    // backgroundColor: darkGreyClr,
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
}

TextStyle get headingStyle {
  return const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

TextStyle get titleStyle {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

TextStyle get subTitleStyle {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.grey.shade400,
  );
}
