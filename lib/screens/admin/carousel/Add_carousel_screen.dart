import 'dart:io';

import 'package:book_heaven/utility/extensions.dart';
import 'package:book_heaven/utility/pick_images.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddCarouselScreen extends StatefulWidget {
  const AddCarouselScreen({super.key});

  @override
  State<AddCarouselScreen> createState() => _AddCarouselScreenState();
}

class _AddCarouselScreenState extends State<AddCarouselScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  File? _image;

  void selectImages() async {
    File? image = await pickImage();
    setState(() {
      _image = image;
    });
  }

  void addCarousel() {
    context.carouselServices.addCarousel(_image!, _title.text, _desc.text,
        context.dataProvider.allCarousels.length + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Carousel"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImages,
                child: _image != null
                    ? Image.file(_image!)
                    : DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Select Book Images",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _desc,
                decoration: const InputDecoration(
                  label: Text("Description"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              // ElevatedButton(
              //   onPressed: addCarousel,
              //   child: const Text("Add"),
              // )
              // Add New Carousel Button with Icon with style
              ElevatedButton.icon(
                onPressed: addCarousel,
                icon: const Icon(Icons.add),
                label: const Text("Add"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
