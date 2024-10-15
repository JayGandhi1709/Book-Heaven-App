import 'package:book_heaven/screens/admin/book/add_book_screen.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: ListView.builder(
        itemCount: context.dataProvider.allBooks.length,
        itemBuilder: (context, index) {
          var book = context.dataProvider.allBooks[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: ListTile(
              // leading: Container(
              //   width: 50,
              //   height: 50,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: NetworkImage(
              //           book.imageUrl.isNotEmpty ? book.imageUrl.first : ''),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              leading: CachedNetworkImage(
                // height: 100,
                imageUrl: book.img.isNotEmpty ? book.img.first : '',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),

              title: Text(book.title),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddBookScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
