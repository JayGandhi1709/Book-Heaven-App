import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:book_heaven/models/address_model.dart';
import 'package:book_heaven/models/order_model.dart';
import 'package:book_heaven/utility/extensions.dart';

class OrderDeatilsScreen extends StatefulWidget {
  const OrderDeatilsScreen({super.key, required this.order});

  final OrderModel order;

  @override
  State<OrderDeatilsScreen> createState() => _OrderDeatilsScreenState();
}

class _OrderDeatilsScreenState extends State<OrderDeatilsScreen> {
  bool editable = false;
  AddressModel? address;
  String? updatedStatus;

  @override
  void initState() {
    address = AddressModel.fromString(widget.order.deliveryAddress);
    editable = context.userController.user.role == "ADMIN";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (_isOrderPlaced)
              //   const Text(
              //     "Thank you for shopping with us. Your order has been placed successfully.",
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              // Show user's address
              const Text(
                "Order Details",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  // title: Text('Current Status: ${widget.order.orderStatus}'),
                  // make status editable
                  title: Row(
                    children: [
                      const Text("Current Status: "),
                      editable
                          ? Expanded(
                              child: DropdownButtonFormField<String>(
                                value:
                                    updatedStatus ?? widget.order.orderStatus,
                                items: [
                                  'pending',
                                  'Shipped',
                                  'Out For delivery',
                                  'Delivered',
                                ]
                                    .map(
                                      (status) => DropdownMenuItem(
                                        value: status,
                                        child: Text(status),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  updatedStatus = value;
                                  setState(() {});
                                },
                              ),
                            )
                          : Text(widget.order.orderStatus),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text("Order ID: ${widget.order.id}"),
                      Text(
                        "Order Date: ${DateFormat.yMMMd().format(
                          DateTime.parse(widget.order.orderDate),
                        )}",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Delivery Details",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(address!.street),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${address!.city}, ${address!.state} - ${address!.zipCode}'),
                      Text("Contact: ${address!.contactNumber}"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Show user's cart items
              const Text(
                "Order Items",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.order.orderItems.length,
                  itemBuilder: (context, index) {
                    var orderItem = widget.order.orderItems[index];
                    return ListTile(
                      leading: Image.network(
                        orderItem.book.img[0],
                        width: 40,
                        height: 80,
                        fit: BoxFit.fitHeight,
                      ),
                      title: Text(
                        orderItem.book.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Price: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                TextSpan(
                                    text:
                                        "₹${(orderItem.bookType == "digital" ? orderItem.book.digitalPrice : orderItem.book.physicalPrice).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    )),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Qty: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                TextSpan(
                                    text: orderItem.quantity.toString(),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    )),
                              ],
                            ),
                          ),
                          // Text("Book Type : ${orderItem.bookType}"),
                          // book Type
                          RichText(
                              text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Book Type: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              TextSpan(
                                text: orderItem.bookType.capitalizeFirst,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                      trailing: Text(
                        "₹${(orderItem.bookType == "digital" ? orderItem.book.digitalPrice : orderItem.book.physicalPrice * orderItem.quantity).toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
              const SizedBox(height: 20),
              // Show total amount
              const Text(
                "Total Amount",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("Subtotal"),
                      trailing: Text(
                        "₹${(widget.order.totalPrice).toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      visualDensity: VisualDensity.compact,
                      dense: true,
                    ),
                    ListTile(
                      title: const Text("GST (8%)"),
                      trailing: Text(
                        "₹${(widget.order.totalPrice * 0.008).ceil().toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      visualDensity: VisualDensity.compact,
                      dense: true,
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Total"),
                      trailing: Text(
                        "₹${(widget.order.totalPrice + (widget.order.totalPrice * 0.008)).ceil().toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: editable
          ? updatedStatus != widget.order.orderStatus && updatedStatus != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // update order status
                      context.orderController.updateOrderStatus(
                        order: widget.order,
                        status: updatedStatus!,
                        showSnack: true,
                      );
                      setState(() {});
                    },
                    child: const Text("Update Status"),
                  ),
                )
              : null
          : null,
    );
  }
}
