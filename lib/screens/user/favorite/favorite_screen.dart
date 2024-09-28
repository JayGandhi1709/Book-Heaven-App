import 'dart:developer';

import 'package:book_heaven/models/book.dart';
import 'package:book_heaven/screens/user/book/view_book.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Book> _favoriteBooks = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteBooks();
  }

  Future<void> _loadFavoriteBooks() async {
    // await context.favoriteController.getAllFavoriteBooks();
    _favoriteBooks = context.favoriteController.allFavoriteBooks;
    setState(() {
      log("Loaded favorite books: ${_favoriteBooks.length}");
    });
    // if (mounted) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: _favoriteBooks.isEmpty
          ? Center(
              child: Text('No favorite books found.'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _favoriteBooks.length,
                    itemBuilder: (context, index) {
                      var book = _favoriteBooks[index];
                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: book.imageUrl.isNotEmpty ? book.imageUrl.first : '',
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        title: Text(book.title),
                        onTap: () => Get.to(()=> ViewBook(book: book)),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            context.favoriteController.addRemoveFavorite(book);
                            setState(() {

                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
