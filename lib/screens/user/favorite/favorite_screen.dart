import 'dart:developer';

import 'package:book_heaven/models/book_model.dart';
import 'package:book_heaven/screens/user/book/view_book.dart';
import 'package:book_heaven/screens/user/favorite/favorite_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use GetBuilder to listen to changes in the favorite controller
    return GetBuilder<FavoriteController>(
      init: FavoriteController(), // Ensure the controller is initialized
      builder: (controller) {
        List<BookModel> favoriteBooks = controller.allFavoriteBooks;

        log("Rebuilding FavoriteScreen with ${favoriteBooks.length} favorite books");

        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorite'),
          ),
          body: favoriteBooks.isEmpty
              ? const Center(
                  child: Text('No favorite books found.'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: favoriteBooks.length,
                        itemBuilder: (context, index) {
                          var book = favoriteBooks[index];
                          return ListTile(
                            leading: CachedNetworkImage(
                              imageUrl:
                                  book.img.isNotEmpty ? book.img.first : '',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            title: Text(book.title),
                            onTap: () => Get.to(() => ViewBook(book: book)),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                controller.addRemoveFavorite(book);
                                // No need to call setState, GetBuilder will handle it
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
