import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List cardNames = [
      'Users',
      'Books',
      'Orders',
      'Categories',
      'Authors',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.userProvider.logOutUser();
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
                context.userProvider.user.name.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                context.userProvider.user.email.toString(),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3.5,
                ),
                itemCount: cardNames.length,
                itemBuilder: (BuildContext context, int index) {
                  var cardName = cardNames[index];
                  return Card(
                    elevation: 2,
                    color: context.theme.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(index.toString()),
                          const Text(
                            '100',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
