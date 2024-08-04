import 'package:animations/animations.dart';
import 'package:book_heaven/screens/admin/add%20book/add_book_screen.dart';
import 'package:book_heaven/screens/admin/dashboard/dashboard_screen.dart';
import 'package:book_heaven/screens/user/cart/cart_screen.dart';
import 'package:book_heaven/screens/user/favorite/favorite_screen.dart';
import 'package:book_heaven/screens/user/home/home_screen.dart';
import 'package:book_heaven/screens/user/home/widgets/botton_nav_bar.dart';
import 'package:book_heaven/screens/user/profile/profile_screen.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int newIndex = 0;
  List<Widget> userScreens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  List<Widget> adminScreens = [
    const DashboardScreen(),
    // const Center(child: Text("Manage")),
    const AddBookScreen(),
    const Center(child: Text("Page 3")),
    const ProfileScreen()
  ];

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
        backgroundColor: Colors.white,
        itemCornerRadius: 10,
        selectedIndex: newIndex,
        items: context.userProvider.user.role == "ADMIN"
            ? adminBottomItems
            : userBottomItems,
        // items: userBottomItems,
        onItemSelected: (currentIndex) {
          newIndex = currentIndex;
          setState(() {});
        },
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(seconds: 1),
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
        // child: screens[newIndex],
        child: IndexedStack(
          index: newIndex,
          children: context.userProvider.user.role == "ADMIN"
              ? adminScreens
              : userScreens,
        ),
      ),
    );
  }
}
