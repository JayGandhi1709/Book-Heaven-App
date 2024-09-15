import 'package:book_heaven/screens/admin/carousel/add_carousel_screen.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselScreen extends StatelessWidget {
  const CarouselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: context.dataProvider.allCarousels.length,
          itemBuilder: (context, index) {
            var carousel = context.dataProvider.allCarousels[index];
            return Container(
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
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: carousel.imageUrl.isNotEmpty ? carousel.imageUrl : '',
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16.0),
                      child: Text(carousel.title),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddCarouselScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
