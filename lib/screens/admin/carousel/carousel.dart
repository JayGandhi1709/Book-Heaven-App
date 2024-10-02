import 'package:book_heaven/common/banner_carousel.dart';
import 'package:book_heaven/models/carousel_model.dart';
import 'package:book_heaven/screens/admin/carousel/add_carousel_screen.dart';
import 'package:book_heaven/utility/custom_dialog.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  List<CarouselModel> carousels = [];
  List<CarouselModel> originalOrder = [];
  bool orderChanged = false;

  @override
  void initState() {
    _loadCarousels();

    super.initState();
  }

  void _loadCarousels({showSnake = false}) async {
    carousels = (await context.dataProvider
            .getAllCarousels(showSnake: showSnake))
        .toList()
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    originalOrder = List.from(carousels); // Copy the list
    orderChanged = false;
    setState(() {});
  }

  // Compare the two lists to check if the order has changed
  bool hasOrderChanged() {
    if (carousels.length != originalOrder.length) return true;
    for (int i = 0; i < carousels.length; i++) {
      if (carousels[i].id != originalOrder[i].id) {
        return true; // If any item is in a different position, return true
      }
    }
    return false;
  }

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final carousel = carousels.removeAt(oldIndex);
      carousels.insert(newIndex, carousel);
      orderChanged = hasOrderChanged(); // Update order changed flag
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _loadCarousels(showSnake: true),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: carousels.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_not_supported, size: 100),
                    SizedBox(height: 10),
                    Text('No carousel found'),
                  ],
                ),
              )
            : Column(
                children: [
                  BannerCarousel(carousels: carousels),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Divider(),
                  ),
                  Expanded(
                    child: ReorderableListView.builder(
                      itemCount: carousels.length,
                      itemBuilder: (context, index) {
                        var carousel = carousels[index];
                        return Row(
                          key: Key(carousel.id
                              .toString()), // Add a unique key for reordering
                          children: [
                            Expanded(
                              child: ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: carousel.imageUrl.isNotEmpty
                                      ? carousel.imageUrl
                                      : '',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                title: Text("${index + 1}. ${carousel.title}"),
                                subtitle: Text(carousel.description),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomDialog(
                                      title: "title",
                                      content: [
                                        TextFormField(
                                          initialValue: carousel.title,
                                          decoration: const InputDecoration(
                                            labelText: 'Title',
                                          ),
                                          onChanged: (value) {
                                            carousel.title = value;
                                          },
                                        ),
                                        TextFormField(
                                          initialValue: carousel.description,
                                          decoration: const InputDecoration(
                                            labelText: 'Description',
                                          ),
                                          onChanged: (value) {
                                            carousel.description = value;
                                          },
                                        ),
                                      ],
                                      onConfirm: () {
                                        context.carouselServices
                                            .updateCarousel(carousel);
                                        setState(() {
                                          context.dataProvider
                                              .getAllCarousels();
                                        });
                                      },
                                      onCancel: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomDialog(
                                      title: 'Delete Carousel',
                                      content: const [
                                        Text(
                                            'Are you sure you want to delete this carousel?')
                                      ],
                                      onConfirm: () async {
                                        await context.carouselServices
                                            .deleteCarousel(carousel.id);
                                        _loadCarousels();
                                        // setState(() {
                                        //   // context.dataProvider
                                        //   //     .getAllCarousels();
                                        //   _loadCarousels();
                                        // });
                                      },
                                      onCancel: () {
                                        Get.back();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Icon(Icons.drag_indicator),
                          ],
                        );
                      },
                      onReorder: _reorder,
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddCarouselScreen());
        },
        child: const Icon(Icons.add),
      ),
      // update Order bottom sheet
      bottomNavigationBar: orderChanged
          ? Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await context.carouselServices
                            .updateCarouselOrder(carousels);
                      },
                      child: const Text('Update Order'),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
