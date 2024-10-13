import 'dart:convert';
import 'dart:developer';

import 'package:book_heaven/models/address_model.dart';
import 'package:book_heaven/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDeatilsScreen extends StatefulWidget {
  const OrderDeatilsScreen({super.key, required this.order});

  final OrderModel order;

  @override
  State<OrderDeatilsScreen> createState() => _OrderDeatilsScreenState();
}

class _OrderDeatilsScreenState extends State<OrderDeatilsScreen> {
  AddressModel? address;

  @override
  void initState() {
    address = AddressModel.fromString(widget.order.deliveryAddress);
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
                  title: Text('Current Status: ${widget.order.orderStatus}'),
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
                                const TextSpan(
                                  text: "Price: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "₹${(orderItem.bookType == "digital" ? orderItem.book.digitalPrice : orderItem.book.physicalPrice).toStringAsFixed(2)}",
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Qty: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: orderItem.quantity.toString(),
                                ),
                              ],
                            ),
                          ),
                          Text("Book Type : ${orderItem.bookType}"),
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
                        "₹${(widget.order.totalPrice / 0.08).toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      visualDensity: VisualDensity.compact,
                      dense: true,
                    ),
                    ListTile(
                      title: const Text("GST"),
                      trailing: Text(
                        "₹${(widget.order.totalPrice / 0.08).ceil().toStringAsFixed(2)}",
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
                        "₹${(widget.order.totalPrice).ceil().toStringAsFixed(2)}",
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
    );
  }
}
