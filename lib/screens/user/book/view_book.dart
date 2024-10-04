import 'package:book_heaven/models/book_model.dart';
import 'package:book_heaven/screens/user/book/custom_pdf_view.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewBook extends StatefulWidget {
  final BookModel book; // Accepting Book as a parameter

  const ViewBook({super.key, required this.book});

  @override
  State<ViewBook> createState() => _ViewBookState();
}

class _ViewBookState extends State<ViewBook> {
  // State variable to track if the full description is shown
  final RxBool showFullDescription = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel
              if (widget.book.img.isNotEmpty)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: PageView.builder(
                        itemCount: widget.book.img.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.book.img[index],
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                    Obx(() => Positioned(
                          bottom: context.mediaQueryPadding.bottom,
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  context.favoriteController
                                      .addRemoveFavorite(widget.book);
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
                              isSelected: context.favoriteController
                                  .isFavorite(widget.book),
                            ),
                          ),
                        )),
                  ],
                ),

              const SizedBox(height: 16.0),

              // Title
              Text(
                widget.book.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              // Authors
              Row(
                children: [
                  const Text(
                    'by, ',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    widget.book.authors.join(', '),
                    style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        color: Colors.blue),
                  ),
                ],
              ),

              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'ISBN',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(widget.book.isbn),
                      // Text(
                      //   'Rating',
                      //   style: TextStyle(
                      //       fontSize: 18, fontWeight: FontWeight.w600),
                      // ),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.star_outline,
                      //       color: Colors.orange, // Set the color to yellow
                      //       size: 20, // You can adjust the size as needed
                      //     ),
                      //     SizedBox(
                      //         width:
                      //             4), // Add some spacing between the star and rating
                      //     Text(
                      //       '${"0"}',
                      //       style: TextStyle(fontSize: 16),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Pages',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${widget.book.page}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Genre',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.book.genre[0],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30.0),
              // Description
              Obx(() {
                String displayDescription = showFullDescription.value
                    ? widget.book.desc
                    : (widget.book.desc.length > 100
                        ? '${widget.book.desc.substring(0, 100)}...'
                        : widget.book
                            .desc); // Show full text if less than 100 characters

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5), // Use SizedBox for spacing
                    Text(
                      displayDescription,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify, // Justify the text
                    ),
                    // Read More / Read Less button
                    GestureDetector(
                      onTap: () {
                        showFullDescription.value = !showFullDescription.value;
                      },
                      child: Text(
                        showFullDescription.value ? 'Read Less' : 'Read More',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 8.0),

              // Price
              Row(
                children: [
                  const Text(
                    'Physical Price: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '₹${widget.book.physicalPrice}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Digital Price: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '₹${widget.book.digitalPrice}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 16.0),
              // make Preview book button
              if (widget.book.hasDigitalCopy && widget.book.fileUrl != null)
                Container(
                  decoration: BoxDecoration(
                    // gradient: const LinearGradient(
                    //   colors: [
                    //     Color(0xff466168),
                    //     Color.fromARGB(255, 128, 160, 168),
                    //     Color.fromARGB(255, 147, 187, 197),
                    //   ], // Specify your gradient colors
                    // ),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(
                        8), // Optional: for rounded corners
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // Make the button transparent
                      shadowColor: Colors.transparent, // Remove shadow
                    ),
                    onPressed: () {
                      Get.to(
                          () => CustomPdfViewer(pdfUrl: widget.book.fileUrl!));
                    },
                    child: const Text(
                      'Preview Book',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.book.hasPhysicalCopy)
              Container(
                decoration: BoxDecoration(
                  // gradient: const LinearGradient(
                  //   colors: [
                  //     Color(0xff466168),
                  //     Color.fromARGB(255, 128, 160, 168),
                  //     Color.fromARGB(255, 147, 187, 197),
                  //   ], // Specify your gradient colors
                  // ),
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.circular(8), // Optional: for rounded corners
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.transparent, // Make the button transparent
                    shadowColor: Colors.transparent, // Remove shadow
                  ),
                  onPressed: () {
                    context.cartController.addToCart(widget.book, "physical");
                    setState(() {});
                  },
                  // child: Text(
                  //   'Buy physical  ₹${widget.book.physicalPrice}',
                  //   style: const TextStyle(color: Colors.white),
                  // ),
                  child: RichText(
                    text: TextSpan(
                      text: "Buy Physical ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: "₹${widget.book.physicalPrice}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            if (widget.book.hasDigitalCopy && widget.book.fileUrl != null)
              Container(
                decoration: BoxDecoration(
                  // gradient: const LinearGradient(
                  //   colors: [
                  //     Color(0xff466168),
                  //     Color.fromARGB(255, 128, 160, 168),
                  //     Color.fromARGB(255, 147, 187, 197),
                  //   ], // Specify your gradient colors
                  // ),
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.circular(8), // Optional: for rounded corners
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.transparent, // Make the button transparent
                    shadowColor: Colors.transparent, // Remove shadow
                  ),
                  onPressed: () {
                    context.cartController.addToCart(widget.book, "digital");
                    setState(() {});
                  },
                  // child: Text(
                  //   'Buy E-Book  ₹${widget.book.digitalPrice}',
                  //   style: const TextStyle(color: Colors.white),
                  // ),
                  child: RichText(
                    text: TextSpan(
                      text: "Buy Digital ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: "₹${widget.book.digitalPrice}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
