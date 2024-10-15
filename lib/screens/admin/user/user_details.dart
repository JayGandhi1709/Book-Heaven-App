import 'package:book_heaven/models/user_model.dart';
import 'package:book_heaven/screens/auth/provider/user_controller.dart';
import 'package:book_heaven/screens/user/address/address_controller.dart';
import 'package:book_heaven/screens/user/order/order_controller.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Assuming you're using GetX for state management

// Assume these are the controllers for user, orders, and addresses

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late OrderController orderController;
  late AddressController addressController;
  @override
  void initState() {
    super.initState();
    // Fetch data when screen initializes
    context.orderController
        .filterOrdersByUserId(userID: widget.user.id!); // Fetch user orders
    context.addressController
        .getAllAddress(userID: widget.user.id!); // Fetch user addresses
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Information
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "User Details",
                    ),
                    const SizedBox(height: 10),
                    Text("Name: ${widget.user.name}"),
                    const SizedBox(height: 10),
                    Text("Email: ${widget.user.email}"),
                    const SizedBox(height: 10),
                  ],
                );
              }),
              const SizedBox(height: 20),

              // Orders Expandable Tile
              Obx(() {
                return ExpansionTile(
                  title: const Text("Orders"),
                  children: orderController.allFilterOrders.map((order) {
                    return ListTile(
                      title: Text("Order ID: ${order.id}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status: ${order.orderStatus}"),
                          Text("Total: \$${order.totalPrice}"),
                          const Divider(),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),

              // Addresses Expandable Tile
              // Obx(() {
              //   return ExpansionTile(
              //     title: const Text("Addresses"),
              //     children: addressController.addresses.map((address) {
              //       return ListTile(
              //         title:
              //             Text("Address: ${address.street}, ${address.city}"),
              //         subtitle: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text("State: ${address.state}"),
              //             Text("Zip Code: ${address.zipCode}"),
              //             Text("Contact: ${address.contactNumber}"),
              //             const Divider(),
              //           ],
              //         ),
              //       );
              //     }).toList(),
              //   );
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
