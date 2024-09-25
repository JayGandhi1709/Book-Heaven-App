import 'package:book_heaven/core/data_provider.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = context.dataProvider;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              dataProvider.getAllUsers(showSnake: true);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dataProvider.allUsers.length,
        itemBuilder: (context, index) {
          var user = dataProvider.allUsers[index];
          return ListTile(
            leading: user.role == "ADMIN"
                ? const Icon(Icons.admin_panel_settings_rounded)
                : const Icon(Icons.person),
            title: Text(
                "${user.name.toString()} (${user.role.toString().toLowerCase()})"),
            subtitle: Text(user.email.toString()),
          );
        },
      ),
    );
  }
}
