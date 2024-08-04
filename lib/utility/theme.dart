import 'package:flutter/material.dart';

var lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  dividerColor: Colors.white54,
);

var darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  dividerColor: Colors.black54,
);

// class ThemeController extends GetxController {
//   var isDarkMode = false.obs;

//   void changeTheme() {
//     Get.changeThemeMode(isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
//     isDarkMode.toggle();
//   }
// }
