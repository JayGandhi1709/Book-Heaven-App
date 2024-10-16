import 'dart:convert';
import 'dart:developer';

import 'package:book_heaven/screens/user/address/address_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:book_heaven/models/cart_model.dart';
import 'package:book_heaven/screens/user/book/view_book.dart';
import 'package:book_heaven/screens/user/cart/cart_controller.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:book_heaven/utility/secret.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(), // Ensure the controller is initialized
      builder: (controller) {
        List<CartModel> cartBooks = controller.allCartBooks;

        log("Rebuilding CartScreen with ${cartBooks.length} cart books");

        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
          ),
          body: cartBooks.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // show svg image flutter_svg
                    SvgPicture.asset(
                      'assets/svg/bookshelves.svg',
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text('No cart books found.'),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartBooks.length,
                        itemBuilder: (context, index) {
                          var cart = cartBooks[index].book;
                          return ListTile(
                            isThreeLine: true,
                            leading: CachedNetworkImage(
                              imageUrl:
                                  cart.img.isNotEmpty ? cart.img.first : '',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            title: Text(cart.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "₹${cartBooks[index].bookType == "digital" ? cart.digitalPrice : cart.physicalPrice} x ${cartBooks[index].quantity}"),
                                // Text("Price : ₹${cart.physicalPrice}"),
                                Text("Type : ${cartBooks[index].bookType}"),
                                // quantity plus and minus
                                if (cartBooks[index].bookType == "physical")
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          controller.updateQuantity(
                                              cart,
                                              cartBooks[index].quantity + 1,
                                              cartBooks[index].bookType);
                                        },
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        cartBooks[index].quantity.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      IconButton(
                                        icon: Icon(
                                          cartBooks[index].quantity == 1
                                              ? Icons.delete
                                              : Icons.remove,
                                        ),
                                        onPressed: () {
                                          controller.updateQuantity(
                                              cart,
                                              cartBooks[index].quantity - 1,
                                              cartBooks[index].bookType);
                                        },
                                      ),
                                    ],
                                  ),
                                if (cartBooks[index].bookType == "digital")
                                  IconButton(
                                    icon: Icon(
                                      cartBooks[index].quantity == 1
                                          ? Icons.delete
                                          : Icons.remove,
                                    ),
                                    onPressed: () {
                                      controller.updateQuantity(
                                          cart,
                                          cartBooks[index].quantity - 1,
                                          cartBooks[index].bookType);
                                    },
                                  ),
                              ],
                            ),
                            onTap: () => Get.to(() => ViewBook(book: cart)),
                            // trailing: IconButton(
                            //   icon: const Icon(Icons.delete),
                            //   onPressed: () {
                            //     controller.removeFromCart(cart, "physical");
                            //   },
                            // ),
                            // total price of the book
                            trailing: Text(
                              "₹${(cartBooks[index].bookType == "digital" ? cart.digitalPrice : cart.physicalPrice * cartBooks[index].quantity).toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
          bottomNavigationBar: controller.allCartBooks.isNotEmpty
              ? SizedBox(
                  height: 100,
                  child: BottomAppBar(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total : ₹${controller.getTotalPrice().toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 25),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(
                              () => const ManageAddressScreen(
                                selectable: true,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            "Checkout",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent?['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Book Heaven'))
          .then((value) {});

      displayPaymentSheet();
    } catch (e, s) {
      print("Error: $e$s");
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        context.cartController.clearCart();
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
