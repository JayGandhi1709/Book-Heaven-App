import 'package:flutter/material.dart';

class AppThemes {
  // Light Theme with Amber colors
  static final lightTheme = ThemeData(
    useMaterial3: true, // Enables Material 3
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFFFC107), // Amber
      secondary: Color(0xFFFFEB3B), // Light Amber
      background: Color(0xFFFFF8E1), // Light Beige
      surface: Color(0xFFFFFFFF), // White
      onPrimary: Colors.black, // Black text on primary color
      onSecondary: Colors.black, // Black text on secondary color
      onSurface: Color(0xFF4E342E), // Dark Brown text on surface
      onBackground: Color(0xFF4E342E), // Dark Brown text on background
    ),
    scaffoldBackgroundColor: const Color(0xFFFFF8E1), // Light Beige background
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFC107), // Amber AppBar
      foregroundColor: Colors.black, // AppBar text color
      elevation: 1, // Shadow for AppBar
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:
          Color(0xFFFFEB3B), // Light Amber for Bottom Navigation Bar
      selectedItemColor: Colors.black, // Black for selected items
      unselectedItemColor: Color(0xFF4E342E), // Dark Brown for unselected items
      elevation: 4, // Shadow for Bottom Navigation Bar
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color(0xFFFFEB3B), // Light Amber for Button background
        foregroundColor: Colors.black, // Black text on buttons
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    chipTheme: const ChipThemeData(
      // backgroundColor: Color(0xFFFFEB3B), // Light Amber for Chip background
      // labelStyle: TextStyle(color: Colors.black), // Black text on chips
      selectedColor: Color(0xFFFFEB3B), // Light Amber text on chips
    ),
    cardTheme: const CardTheme(
      color: Color(0xFFFFFFFF), // White card color
      shadowColor: Colors.black12,
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF4E342E), // Dark Brown for icons
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF4E342E)), // Dark Brown text
      bodyMedium: TextStyle(color: Color(0xFF4E342E)), // Dark Brown text
    ),
  );

  // Dark Theme with Amber colors
  static final darkTheme = ThemeData(
    useMaterial3: true, // Enables Material 3
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFF9800), // Deep Amber
      secondary: Color(0xFFFFB300), // Amber Accent
      background: Color(0xFF121212), // Charcoal background
      surface: Color(0xFF1E1E1E), // Dark Grey
      onPrimary: Color(0xFFFFF8E1), // Light Beige text on primary color
      onSecondary: Color(0xFFFFF8E1), // Light Beige text on secondary color
      onSurface: Color(0xFFFFF8E1), // Light Beige text on surface
      onBackground: Color(0xFFFFF8E1), // Light Beige text on background
    ),
    scaffoldBackgroundColor: const Color(0xFF121212), // Charcoal background
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFF9800), // Deep Amber AppBar
      foregroundColor: Color(0xFFFFF8E1), // Light Beige text color
      elevation: 1, // Shadow for AppBar
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E), // Dark Grey for Bottom Navigation Bar
      selectedItemColor: Colors.amber, // Light Beige for selected items
      unselectedItemColor: Colors.grey, // Light Gray for unselected items
      elevation: 4, // Shadow for Bottom Navigation Bar
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color(0xFFFFB300), // Amber Accent for Button background
        foregroundColor: const Color(0xFFFFF8E1), // Light Beige text on buttons
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    chipTheme: const ChipThemeData(
      // backgroundColor: Color(0xFFFFB300), // Amber Accent for Chip background
      // labelStyle: TextStyle(
      //   color: Color(0xFFFFF8E1),
      // ), // Light Beige text on chips
      selectedColor: Color(0xFFFFB300), // Light Beige text on chips
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF1E1E1E), // Dark Grey card color
      shadowColor: Colors.black12,
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFFFF8E1), // Light Beige for icons
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFFFF8E1)), // Light Beige text
      bodyMedium: TextStyle(color: Color(0xFFFFF8E1)), // Light Beige text
    ),
  );
}








// import 'package:flutter/material.dart';

// var lightTheme = ThemeData(
//   primarySwatch: Colors.blue,
//   primaryColor: Colors.white,
//   brightness: Brightness.light,
//   dividerColor: Colors.white54,
//   textTheme: const TextTheme(
//     bodyLarge: TextStyle(color: Colors.black),
//     bodyMedium: TextStyle(color: Colors.black),
//   ),
//   appBarTheme: const AppBarTheme(
//     centerTitle: true,
//     titleTextStyle: TextStyle(
//       color: Colors.blue,
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
//   colorScheme: const ColorScheme.light(
//     primary: Colors.blue,
//     secondary: Colors.amber,
//   ),
// );

// var darkTheme = ThemeData(
//   primarySwatch: Colors.blue,
//   primaryColor: Colors.black,
//   brightness: Brightness.dark,
//   dividerColor: Colors.black54,
//   textTheme: const TextTheme(
//     bodyLarge: TextStyle(color: Colors.white),
//     bodyMedium: TextStyle(color: Colors.white),
//   ),
//   appBarTheme: const AppBarTheme(
//     centerTitle: true,
//     titleTextStyle: TextStyle(
//       color: Colors.amber,
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
//   colorScheme: const ColorScheme.dark(
//     primary: Colors.amber,
//     secondary: Colors.blue,
//   ),
// );

// // class ThemeController extends GetxController {
// //   var isDarkMode = false.obs;

// //   void changeTheme() {
// //     Get.changeThemeMode(isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
// //     isDarkMode.toggle();
// //   }
// // }
