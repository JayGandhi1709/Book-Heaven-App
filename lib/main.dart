import 'package:book_heaven/screens/auth/splash_screen.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:book_heaven/utility/locale.dart';
import 'package:book_heaven/utility/secret.dart';
import 'package:book_heaven/utility/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  Stripe.publishableKey = publishablekey;
  await GetStorage.init("favorite");
  await GetStorage.init("cart");
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
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: context.themeController.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
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
      // home: const AddBookScreen(),
    );
  }
}
