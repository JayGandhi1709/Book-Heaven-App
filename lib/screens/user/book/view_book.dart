
import 'package:book_heaven/models/book.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';

class ViewBook extends StatefulWidget {
  final Book book;
  const ViewBook({super.key, required this.book});

  @override
  State<ViewBook> createState() => _ViewBookState();
}

class _ViewBookState extends State<ViewBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Image.network(
              //   book.imageUrl[0],
              //   height: 300,
              //   width: double.infinity,
              //   fit: BoxFit.contain,
              // ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.book.imageUrl.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.book.imageUrl[index],
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        widget.book.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        "₹${widget.book.physicalPrice}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    Text(
                      widget.book.authors.join(", "),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.book.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // author
                    ListTile(
                      title: const Text("Author"),
                      trailing: Text(
                        widget.book.authors.join(", "),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text("Price"),
                      trailing: Text(
                        "\₹${widget.book.physicalPrice}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // page
                    ListTile(
                      title: const Text("Page"),
                      trailing: Text(
                        widget.book.page.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // language
                    ListTile(
                      title: const Text("Language"),
                      trailing: Text(
                        widget.book.language,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // publisher
                    ListTile(
                      title: const Text("Publisher"),
                      trailing: Text(
                        widget.book.publisher,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // published date
                    ListTile(
                      title: const Text("Published Date"),
                      trailing: Text(
                        widget.book.publicationYear,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Add to Cart"),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  context.favoriteController.addRemoveFavorite(widget.book);
                });
              },
              // icon: context.favoriteController.isFavorite(book) ? Icons.favorite : Icons.favorite_border,
              //     ? const Icon(
              //         Icons.favorite,
              //         color: Colors.red,
              //       )
              //     : const Icon(Icons.favorite_border),
              icon: const Icon(Icons.favorite_border),
              selectedIcon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              isSelected: context.favoriteController.isFavorite(widget.book),
            )
          ],
        ),
      ),
    );
  }
}
