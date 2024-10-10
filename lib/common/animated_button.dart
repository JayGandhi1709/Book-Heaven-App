import 'package:flutter/material.dart';

class AnimatedPlaceOrderButton extends StatefulWidget {
  @override
  _AnimatedPlaceOrderButtonState createState() =>
      _AnimatedPlaceOrderButtonState();
}

class _AnimatedPlaceOrderButtonState extends State<AnimatedPlaceOrderButton>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  bool _isSuccess = false;

  // Simulate placing order
  void _placeOrder() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a delay for order processing
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _isSuccess = true;
    });

    // Keep success state visible for 2 seconds before resetting
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSuccess = false;
    });
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
}
