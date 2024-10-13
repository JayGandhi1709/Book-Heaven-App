import 'package:book_heaven/screens/user/order/order_controller.dart';
import 'package:book_heaven/screens/user/order/order_details_screen.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Orders"),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<OrderController>(
          init: OrderController(context.userController.user.id!),
          builder: (controller) {
            // make custom Card for each address
            if (controller.allOrders.isEmpty) {
              return const Center(
                child: Text("No Orders Found"),
              );
            }
            return Column(
              children: controller.allOrders
                  .map(
                    (order) => Card(
                      child: ListTile(
                        leading: SizedBox(
                          height: 250,
                          // width: 200,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (order.orderItems.length > 1)
                                Positioned(
                                  right: 10,
                                  top: -15,
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          order.orderItems[1].book.img.first,
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        order.orderItems.first.book.img.first),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Text(order.orderItems.first.book.title),
                        onTap: () {
                          Get.to(() => OrderDeatilsScreen(order: order));
                        },
                        // subtitle: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //         '${order.city}, ${order.state} - ${order.zipCode}'),
                        //     Text("Contact: ${order.contactNumber}"),
                        //   ],
                        // ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
