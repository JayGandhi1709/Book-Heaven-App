import 'dart:developer';

import 'package:book_heaven/models/book_model.dart';
import 'package:book_heaven/models/cart_model.dart';
import 'package:book_heaven/screens/user/book/view_book.dart';
import 'package:book_heaven/screens/user/cart/cart_controller.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
              ? const Center(
                  child: Text('No cart books found.'),
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
                                    "₹${cartBooks[index].bookType == "digital" ? cart.digitalPrice : cart.physicalPrice}  x ${cartBooks[index].quantity}"),
                                Text("Price : ₹${cart.physicalPrice}"),
                                Text("Type : ${cartBooks[index].bookType}"),
                                // quantity plus and minus
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
          bottomNavigationBar: SizedBox(
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
                      showSnackBar(
                        "This feature is coming soon",
                        title: "Coming Soon",
                        MsgType.info,
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
          ),
        );
      },
    );
  }
}
