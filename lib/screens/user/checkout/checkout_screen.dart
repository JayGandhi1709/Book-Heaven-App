import 'package:book_heaven/common/animated_button.dart';
import 'package:book_heaven/common/banner_carousel.dart';
import 'package:book_heaven/models/address.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.selectedAddress});

  final AddressModel selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show user's address
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
                  title: Text(selectedAddress.street),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${selectedAddress.city}, ${selectedAddress.state} - ${selectedAddress.zipCode}'),
                      Text("Contact: ${selectedAddress.contactNumber}"),
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
                  itemCount: context.cartController.allCartBooks.length,
                  itemBuilder: (context, index) {
                    var cartItem = context.cartController.allCartBooks[index];
                    return ListTile(
                      leading: Image.network(
                        cartItem.book.img[0],
                        width: 40,
                        height: 80,
                        fit: BoxFit.fitHeight,
                      ),
                      title: Text(
                        cartItem.book.title,
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
                                      "₹${(cartItem.bookType == "digital" ? cartItem.book.digitalPrice : cartItem.book.physicalPrice).toStringAsFixed(2)}",
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
                                  text: cartItem.quantity.toString(),
                                ),
                              ],
                            ),
                          ),
                          Text("Book Type : ${cartItem.bookType}"),
                        ],
                      ),
                      trailing: Text(
                        "₹${(cartItem.bookType == "digital" ? cartItem.book.digitalPrice : cartItem.book.physicalPrice * cartItem.quantity).toStringAsFixed(2)}",
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
                        "₹${context.cartController.getTotalPrice().toStringAsFixed(2)}",
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
                        "₹${(context.cartController.getTotalPrice() * 0.008).toStringAsFixed(2)}",
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
                        "₹${(context.cartController.getTotalPrice() + (context.cartController.getTotalPrice() * 0.008)).toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Show payment options
              // Show place order button
              const SizedBox(height: 20),
              // Center(
              //   child: ElevatedButton.icon(
              //     onPressed: () {
              //       // Place order
              //       // context.cartController.placeOrder(selectedAddress);
              //     },
              //     icon: const Icon(Icons.shopping_cart_checkout),
              //     label: const Text("Place Order"),
              //     style: ElevatedButton.styleFrom(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 24, vertical: 12),
              //       textStyle: const TextStyle(fontSize: 18),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //   ),
              // ),
              AnimatedPlaceOrderButton(),
            ],
          ),
        ),
      ),
    );
  }
}
