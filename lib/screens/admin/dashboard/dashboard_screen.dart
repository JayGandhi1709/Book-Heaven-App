import 'package:book_heaven/screens/admin/book/book_screen.dart';
import 'package:book_heaven/screens/admin/carousel/carousel.dart';
import 'package:book_heaven/screens/admin/user/user_screen.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // context.dashboardProvider.count();
    context.dataProvider.onAdminInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Map<String, String>> cardNames = [
    //   {
    //     'name': 'Users',
    //     'count': context.dataProvider.allUsers.length.toString()
    //   },
    //   {
    //     'name': 'Books',
    //     'count': context.dataProvider.allBooks.length.toString()
    //   },
    //   {'name': 'Orders', 'count': '10'},
    //   {'name': 'Categories', 'count': '10'},
    //   {'name': 'Authors', 'count': '10'},
    // ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                  Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              setState(() {});
            },
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.dataProvider.onAdminInit();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.userController.logOutUser();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(CupertinoIcons.person, size: 20),
              const SizedBox(height: 5),
              Text(
                context.userController.user.name.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                context.userController.user.email.toString(),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () {
                  List<Map<String, dynamic>> cardNames = [
                    {
                      'name': 'Users',
                      'count': context.dataProvider.allUsers.length.toString(),
                      'onTap': () => Get.to(() => const UserScreen()),
                    },
                    {
                      'name': 'Books',
                      'count': context.dataProvider.allBooks.length.toString(),
                      'onTap': () => Get.to(() => const BookScreen()),
                    },
                    {
                      'name': 'Carousels',
                      'count':
                          context.dataProvider.allCarousels.length.toString(),
                      'onTap': () => Get.to(() => const CarouselScreen()),
                    },
                    // {
                    //   'name': 'Orders',
                    //   'count': '10',
                    //   'onTap': () {},
                    // },
                    // {
                    //   'name': 'Categories',
                    //   'count': '10',
                    //   'onTap': () {},
                    // },
                    // {
                    //   'name': 'Authors',
                    //   'count': '10',
                    //   'onTap': () {},
                    // },
                  ];

                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: cardNames.length,
                    itemBuilder: (BuildContext context, int index) {
                      var cardName = cardNames[index];
                      return Card(
                        elevation: 2,
                        // color: context.theme.cardColor,
                        // color: Get.isDarkMode ? Colors.grey[800] : Colors.white,
                        color: Get.isDarkMode ? Colors.grey[800] : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: cardName['onTap'],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(cardName['name'] ?? ''),
                                Text(
                                  cardName['count'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
