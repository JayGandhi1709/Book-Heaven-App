import 'dart:convert';
import 'dart:developer';

import 'package:book_heaven/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import 'package:book_heaven/common/animated_button.dart';
import 'package:book_heaven/models/address_model.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:book_heaven/utility/secret.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.selectedAddress});

  final AddressModel selectedAddress;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Map<String, dynamic>? paymentIntent;
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
                  title: Text(widget.selectedAddress.street),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${widget.selectedAddress.city}, ${widget.selectedAddress.state} - ${widget.selectedAddress.zipCode}'),
                      Text("Contact: ${widget.selectedAddress.contactNumber}"),
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
                        "₹${(context.cartController.getTotalPrice() * 0.008).ceil().toStringAsFixed(2)}",
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
                        "₹${(context.cartController.getTotalPrice() + (context.cartController.getTotalPrice() * 0.008).ceil()).toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AnimatedPlaceOrderButton(
                amount: (context.cartController.getTotalPrice() +
                    (context.cartController.getTotalPrice() * 0.008).ceil()),
                selectedAddress: widget.selectedAddress.toJson().toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent?['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Book Heaven'))
          .then((value) {});

      return displayPaymentSheet();
    } catch (e, s) {
      print("Error: $e$s");
    }
    return false;
  }

  Future<bool> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        log('PaymentSheet response: ${widget.selectedAddress.toJson()}');
        context.orderController.placeOrder(
          order: OrderModel(
            userId: context.userController.user.id!,
            deliveryAddress: widget.selectedAddress.toJson().toString(),
            orderItems: context.cartController.allCartBooks,
            totalPrice: context.cartController.getTotalPrice() +
                (context.cartController.getTotalPrice() * 0.008).ceil(),
            orderDate: DateTime.now().toString(),
            paymentMethod: 'card',
            orderStatus: 'panding',
            isDigitalOrder: context.cartController.allCartBooks
                .every((element) => element.bookType == 'digital'),
          ),
        );
        // context.cartController.clearCart();
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text('Payment Successful'),
                        ],
                      )
                    ],
                  ),
                ));
        paymentIntent = null;
        return true;
        // clear cart
      }).onError((error, stackTrace) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          Text('Payment Failed'),
                        ],
                      )
                    ],
                  ),
                ));
        return false;
      });
    } on StripeException catch (e) {
      print('StripeException: ${e.error.localizedMessage}');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text('Cancelled'),
              ));
    } catch (e) {
      print('Unknown error: $e');
    }
    return false;
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secret',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user : ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100);
    return calculatedAmount.toString();
  }
}
