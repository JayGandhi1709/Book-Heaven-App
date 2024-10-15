import 'dart:convert';
import 'dart:developer';

import 'package:book_heaven/models/order_model.dart';
import 'package:book_heaven/screens/user/order/order_details_screen.dart';
import 'package:book_heaven/utility/secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:book_heaven/utility/extensions.dart';

class AnimatedPlaceOrderButton extends StatefulWidget {
  const AnimatedPlaceOrderButton({
    super.key,
    required this.amount,
    required this.selectedAddress,
  });

  final double amount;
  final String selectedAddress;

  @override
  _AnimatedPlaceOrderButtonState createState() =>
      _AnimatedPlaceOrderButtonState();
}

class _AnimatedPlaceOrderButtonState extends State<AnimatedPlaceOrderButton>
    with TickerProviderStateMixin {
  Map<String, dynamic>? paymentIntent;
  bool _isLoading = false;
  bool _isSuccess = false;

  // Simulate placing order
  void _placeOrder() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a delay for order processing
    await Future.delayed(const Duration(seconds: 2));
    _isSuccess = await makePayment(widget.amount.toStringAsFixed(0));
    await Future.delayed(const Duration(seconds: 2));

    log('isSuccess: $_isSuccess');
    setState(() {
      _isLoading = false;
    });
    await Future.delayed(const Duration(seconds: 2));

    // if (_isSuccess) {
    //   // Get.until((route) => route.isFirst);
    //   Get.offAll(() => const OrderScreen(order: ,));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 60,
        width: _isLoading || _isSuccess ? 60 : 200,
        decoration: BoxDecoration(
          color: _isSuccess ? Colors.green : Colors.blue,
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: _isLoading || _isSuccess ? null : _placeOrder,
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : _isSuccess
                    ? const Icon(Icons.check, color: Colors.white, size: 30)
                    : const Text(
                        "Place Order",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

      return await displayPaymentSheet();
    } catch (e, s) {
      print("Error: $e$s");
      return false;
    }
  }

  Future<bool> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      // If the payment sheet was presented successfully
      await context.orderController.placeOrder(
        order: OrderModel(
          userId: context.userController.user.id!,
          deliveryAddress: widget.selectedAddress,
          orderItems: context.cartController.allCartBooks,
          totalPrice: widget.amount,
          orderDate: DateTime.now().toString(),
          paymentMethod: 'card',
          orderStatus: 'pending', // Fix typo from 'panding' to 'pending'
          isDigitalOrder: context.cartController.allCartBooks
              .every((element) => element.bookType == 'digital'),
        ),
      );

      // clear cart
      context.cartController.clearCart();

      // Show success dialog
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
        ),
      );

      // Clear the cart if payment is successful
      // context.cartController.clearCart();

      // Delay before popping the dialog
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(); // Close the success dialog
      });

      paymentIntent = null; // Clear payment intent
      return true;
    } catch (e) {
      // Handle Stripe exception separately
      if (e is StripeException) {
        print('StripeException: ${e.error.localizedMessage}');
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text('Payment Cancelled'),
          ),
        );
      } else {
        print('Unknown error: $e');
      }

      // Show error dialog if payment failed
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
        ),
      );

      // Delay before closing error dialog
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(); // Close the error dialog
      });

      return false;
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
