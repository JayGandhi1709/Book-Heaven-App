import 'package:animations/animations.dart';
import 'package:book_heaven/screens/admin/book/add_book_screen.dart';
import 'package:book_heaven/screens/admin/dashboard/dashboard_screen.dart';
import 'package:book_heaven/screens/user/cart/cart_screen.dart';
import 'package:book_heaven/screens/user/favorite/favorite_screen.dart';
import 'package:book_heaven/screens/user/home/home_screen.dart';
import 'package:book_heaven/screens/user/home/widgets/botton_nav_bar.dart';
import 'package:book_heaven/screens/user/profile/profile_screen.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  @override
  void initState() {
    context.userController.isLoggedIn.listen((value) {
      context.userController.user.role == "ADMIN"
          ? context.dataProvider.onAdminInit()
          : userInit();
    });
    super.initState();
  }

  void userInit() {
    context.dataProvider.onUserInit();
  }

  int newIndex = 0;

  // User Screens
  List<Widget> userScreens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  // Admin Screens
  List<Widget> adminScreens = [
    const DashboardScreen(),
    const AddBookScreen(),
    const Center(child: Text("Page 3")),
    const ProfileScreen()
  ];

  // Bottom navigation items for users
  List<BottomNavyBarItem> userBottomItems = [
    BottomNavyBarItem(
      icon: const Icon(Icons.home),
      title: const Text('Home'),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.favorite),
      title: const Text('Favorite'),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.shopping_cart),
      title: const Text('Cart'),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.person),
      title: const Text('Profile'),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
  ];

  // Bottom navigation items for admins
  List<BottomNavyBarItem> adminBottomItems = [
    BottomNavyBarItem(
      icon: const Icon(Icons.home),
      title: const Text('Home'),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.book),
      title: const Text('Books'),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.shopping_cart),
      title: const Text('Cart'),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.person),
      title: const Text('Profile'),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
        itemCornerRadius: 10,
        selectedIndex: newIndex,
        items: context.userController.user.role == "ADMIN"
            ? adminBottomItems
            : userBottomItems,
        onItemSelected: (currentIndex) {
          setState(() {
            newIndex = currentIndex; // Update the selected index and rebuild
          });
        },
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 300), // Adjust transition time
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        // Directly display the selected screen based on newIndex
        // child: context.userProvider.user.role == "ADMIN"
        //     ? adminScreens[newIndex]
        //     : userScreens[newIndex],
        child: IndexedStack(
          index: newIndex,
          children: context.userController.user.role == "ADMIN"
              ? adminScreens
              : userScreens,
        ),
      ),
    );
  }
}
