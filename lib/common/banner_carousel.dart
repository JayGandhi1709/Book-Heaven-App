// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:book_heaven/models/carousel_model.dart';
import 'package:book_heaven/utility/extensions.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({
    super.key,
    this.carousels = const [],
  });

  final List<CarouselModel> carousels;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void initState() {
    if (widget.carousels.isEmpty) {
      widget.carousels.addAll(context.dataProvider.allCarousels);
    }
    widget.carousels.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.carousels.length <= 0
        ? SizedBox.shrink()
        : Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.grey.shade400,
                  //       spreadRadius: 2,
                  //       blurRadius: 10)
                  // ],
                  borderRadius: BorderRadius.circular(8),
                ),
                width: MediaQuery.sizeOf(context).width,
                child: CarouselSlider.builder(
                  itemCount: widget.carousels.length,
                  carouselController: _controller,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: widget.carousels[index].imageUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.sizeOf(context).width,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
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
                children: widget.carousels.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
  }
}
