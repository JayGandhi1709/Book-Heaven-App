import 'package:book_heaven/screens/user/E%20book/ebooks_screen.dart';
import 'package:book_heaven/screens/user/address/address_screen.dart';
import 'package:book_heaven/screens/user/order/orders_screen.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> settingsItem = [
      // {"icon": Icons.account_circle, "title": "Account"},
      {
        "icon": Icons.menu_book_sharp,
        "title": "E-Books",
        "onTap": () => Get.to(() => const EBooksScreen())
      },
      {
        "icon": Icons.apartment,
        "title": "Manage Address",
        "onTap": () => Get.to(const ManageAddressScreen()),
      },
      {
        "icon": Icons.shopping_cart,
        "title": "Orders",
        "onTap": () => Get.to(() => const OrdersScreen())
      },
      // {"icon": Icons.favorite, "title": "Wishlist"},
      // {"icon": Icons.settings, "title": "Settings"},
      // {"icon": Icons.help, "title": "Help"},
      {
        "icon": Icons.logout,
        "title": "Logout",
        "color": Colors.red,
        "onTap": context.userController.logOutUser
      },
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
              setState(() {});
            },
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     context.userProvider.logOutUser();
          //   },
          //   child: const Text("Logout"),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                context.userController.user.name!.capitalize ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                context.userController.user.email ?? "",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 35),
              ...settingsItem.map(
                (e) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: ListTile(
                      leading: Icon(e['icon']),
                      title: Text(
                        e['title'],
                        style: TextStyle(color: e['color']),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: e['onTap'] ??
                          () {
                            // Get.snackbar(
                            //   "Coming Soon",
                            //   "This feature is coming soon",
                            // );
                            showSnackBar(
                              "This feature is coming soon",
                              title: "Coming Soon",
                              MsgType.info,
                            );
                          },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
