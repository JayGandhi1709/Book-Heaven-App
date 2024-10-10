import 'package:book_heaven/screens/admin/dashboard/dashboard_screen.dart';
import 'package:book_heaven/screens/auth/log_in_screen.dart';
import 'package:book_heaven/screens/main_home_screen.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.userController.isLoggedIn.listen((value) {
      if (value) {
        Future.delayed(const Duration(seconds: 0), () {
          // Get.offAll(() => const MainHomeScreen());
          Get.offAll(() => context.userController.user.role == "ADMIN"
              ? const DashboardScreen()
              : const MainHomeScreen());
        });
      } else {
        Get.offAll(() => const LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/splashlogo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              "Book Heaven",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 100),
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
