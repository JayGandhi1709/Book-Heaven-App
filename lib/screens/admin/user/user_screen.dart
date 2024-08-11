import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: ListView.builder(
        itemCount: context.dataProvider.allUsers.length,
        itemBuilder: (context, index) {
          var user = context.dataProvider.allUsers[index];
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
