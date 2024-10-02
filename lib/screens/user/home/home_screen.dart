import 'package:book_heaven/common/banner_carousel.dart';
import 'package:book_heaven/models/book_model.dart';
import 'package:book_heaven/models/carousel_model.dart';
import 'package:book_heaven/screens/user/book/view_book.dart';
import 'package:book_heaven/utility/constants.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CarouselModel> carousels = [];
  List<CarouselModel> originalOrder = [];
  List<BookModel> books = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _loadCarousels();
    _loadBooks();
    super.initState();
  }

  void _loadCarousels({showSnake = false}) async {
    carousels = (await context.dataProvider
            .getAllCarousels(showSnake: showSnake))
        .toList()
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    originalOrder = List.from(carousels); // Copy the list
    setState(() {});
  }

  void _loadBooks() async {
    await context.dataProvider.getAllBooks();
    books.addAll(context.dataProvider.allBooks);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 1,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  // suffixIcon: IconButton(
                  //   key: Key('clearButton'),
                  //   icon: const Icon(Icons.clear),
                  //   onPressed: () {
                  //     searchController.clear();
                  //   },
                  // ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.only(top: 10),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Book_Genres.length,
                    itemBuilder: (context, index) {
                      var genre = Book_Genres[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1)
                            .copyWith(right: 10),
                        child: ActionChip(
                            label: Text(genre),
                            onPressed: () {
                              setState(() {
                                searchController.text = genre;
                              });
                            }),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                BannerCarousel(carousels: carousels),
                const SizedBox(height: 20),
                const Text(
                  "Popular Books",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  // height: 600, // Adjust height as needed to fit your design
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Prevents scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Get.width > 800 ? 4 : 2,
                      childAspectRatio: Get.width / Get.height * 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      var book = books[index];
                      return Card(
                        elevation: 3,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () => Get.to(() => ViewBook(book: book)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align text to the start
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        book.img.isNotEmpty ? book.img[0] : '',
                                    height: 150,
                                    width: double
                                        .infinity, // Fill the width of the container
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  book.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  book.authors.join(", "),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
