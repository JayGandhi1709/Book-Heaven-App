import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:book_heaven/screens/auth/splash_screen.dart';
import 'package:book_heaven/utility/locale.dart';
import 'package:book_heaven/utility/theme.dart';

void main() async {
  // await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialBinding: BindingsBuilder(() {
      //   Future.delayed(Duration(seconds: 3), () {
      //     Get.put(UserProvider());
      //   });
      //   // Get.put(UserProvider());
      // }),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      // locale: Locale("hi", "IN"),
      locale: const Locale("en", "US"),
      fallbackLocale: const Locale("en", "US"),
      translations: Languages(),
      // initialRoute: "/",
      // home: Obx(
      //   () => context.userProvider.isLoggedIn.value
      //       ? context.userProvider.user.role == "ADMIN"
      //           ? AdminScreen()
      //           : MainHomeScreen()
      //       : LoginScreen(),
      // ));
      home: const SplashScreen(),
    );
  }
}
