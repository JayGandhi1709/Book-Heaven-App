import 'package:book_heaven/screens/auth/splash_screen.dart';
import 'package:book_heaven/utility/constants.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void initState() {
    // TODO: implement initState
    context.dataProvider.onUserInit();
    super.initState();
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
                SizedBox(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                  child: CarouselSlider.builder(
                    itemCount: context.dataProvider.allCarousels.length,
                    carouselController: _controller,
                    itemBuilder: (context, index, realIndex) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl:
                              context.dataProvider.allCarousels[index].imageUrl,
                          fit: BoxFit.cover,
                          width: MediaQuery.sizeOf(context).width,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: false,
                      autoPlayInterval:
                          const Duration(seconds: 5), // 3 seconds per slide
                      enlargeCenterPage: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: context.dataProvider.allCarousels
                      .asMap()
                      .entries
                      .map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ));
  }
}
