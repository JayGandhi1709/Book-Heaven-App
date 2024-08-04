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
    // TODO: implement initState
    // context.userProvider.getLoginUsr();
    context.userProvider.isLoggedIn.listen((value) {
      if (value) {
        Future.delayed(const Duration(seconds: 3), () {
          // context.userProvider.user.role == "ADMIN"
          //     ? Get.offAll(() => const AdminScreen())
          //     : Get.offAll(() => const MainHomeScreen());
          Get.offAll(() => const MainHomeScreen());
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(color: Colors.amberAccent
                // image: DecorationImage(
                //   image: AssetImage('assets/images/logo.png'),
                //   fit: BoxFit.contain,
                // ),
                ),
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
