import 'package:book_heaven/screens/user/order/order_controller.dart';
import 'package:book_heaven/screens/user/order/order_details_screen.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String selectedBookTypeFilter = "All";
  String selectedStatusFilter = "All";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Orders"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: GetBuilder<OrderController>(
            init: OrderController(context.userController.user),
            builder: (controller) {
              // make custom Card for each address
              if (controller.allOrders.isEmpty) {
                return const Center(
                  child: Text("No Orders Found"),
                );
              }
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // action chip filter
                    Wrap(
                      children: [
                        "All",
                        "Pending",
                        "Delivered",
                      ]
                          .map(
                            (filter) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ActionChip(
                                label: Text(filter),
                                backgroundColor: selectedStatusFilter == filter
                                    ? Colors.blue
                                    : Colors.grey,
                                onPressed: () {
                                  controller.filterOrders(
                                      status: selectedStatusFilter,
                                      bookType: selectedBookTypeFilter);
                                  selectedStatusFilter = filter;
                                  setState(() {});
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    Wrap(
                      children: ["All", "E-Books", "Physical"]
                          .map(
                            (filter) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ActionChip(
                                label: Text(filter),
                                backgroundColor:
                                    selectedBookTypeFilter == filter
                                        ? Colors.blue
                                        : Colors.grey,
                                onPressed: () {
                                  controller.filterOrders(
                                      status: selectedStatusFilter,
                                      bookType: selectedBookTypeFilter);
                                  selectedBookTypeFilter = filter;
                                  setState(() {});
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    ...controller.allFilterOrders.map(
                      (order) => GestureDetector(
                        onTap: () {
                          Get.to(() => OrderDeatilsScreen(order: order));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                order.orderItems[1].book.img
                                                    .first,
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
                                          image: NetworkImage(order
                                              .orderItems.first.book.img.first),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              title: Text(
                                order.orderItems.first.book.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

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
                        ),
                      ),
                    ),
                  ]);
            },
          ),
        ),
      ),
    );
  }
}
