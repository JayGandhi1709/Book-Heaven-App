import 'dart:developer';

import 'package:book_heaven/models/book.dart';
import 'package:book_heaven/screens/user/book/view_book.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Book> _cartBooks = [];

  @override
  void initState() {
    super.initState();
    _loadCartBooks();
  }

  Future<void> _loadCartBooks() async {
    // await context.favoriteController.getAllFavoriteBooks();
    _cartBooks = context.cartController.allCartBooks;
    setState(() {
      log("Loaded cart books: ${_cartBooks.length}");
    });
    // if (mounted) {}
  }

  double _calculateTotal() {
    return _cartBooks.fold(0, (total, book) => total + book.physicalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: _cartBooks.isEmpty
          ? Center(
        child: Text('No cart books found.'),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cartBooks.length,
              itemBuilder: (context, index) {
                var book = _cartBooks[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: book.imageUrl.isNotEmpty
                        ? book.imageUrl.first
                        : '',
                    placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                  title: Text(book.title),
                  subtitle: Text("₹${book.physicalPrice}"),
                  onTap: () => Get.to(() => ViewBook(book: book)),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                    ),
                    onPressed: () {
                      context.cartController.addRemoveCart(book);
                      setState(() {});
                    },
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
              Text("Total : ₹${_calculateTotal().toStringAsFixed(2)}",style: TextStyle(fontSize: 25),),
              ElevatedButton(onPressed: (){
                showSnackBar(
                  "This feature is coming soon",
                  title: "Coming Soon",
                  MsgType.info,
                );
              }, child: Text("Checkout",style: TextStyle(fontSize: 20,color: Colors.black),),style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
