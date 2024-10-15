import 'dart:io';

import 'package:book_heaven/common/custom_text_form_field.dart';
import 'package:book_heaven/common/editable_chip_field_widget.dart';
import 'package:book_heaven/utility/constants.dart';
import 'package:book_heaven/utility/pick_images.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  void addCarousel() {
    // context.carouselServices.addCarousel(_image!, _title.text, _desc.text,
    //     context.dataProvider.allCarousels.length + 1);
  }

  // controllers
  // final TextEditingController _title = TextEditingController();
  // final TextEditingController _desc = TextEditingController();
  List<File>? _images;

  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _publicationYearController =
      TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _physicalPriceController =
      TextEditingController();
  final TextEditingController _digitalPriceController = TextEditingController();
  final TextEditingController _pageController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  // TextEditingController _pdfUrlController = TextEditingController();
  File? pdf;
  final List<String> _genreController = [];

  void selectImages() async {
    List<File>? image = await pickMultipleImages();
    setState(() {
      _images!.addAll(image);
    });
  }

  // select pdf
  void selectPdf() async {
    File? pdfFile = await pickPdf();
    setState(() {
      pdf = pdfFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Book'),
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  _images != null && _images!.isNotEmpty
                      ? SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _images!.length + 1,
                            itemBuilder: (context, index) {
                              if (index == _images!.length) {
                                return GestureDetector(
                                  onTap: selectImages,
                                  child: Container(
                                    width: 100,
                                    height: 150,
                                    color: Get.theme.colorScheme.onSurface,
                                    child: const Icon(
                                      Icons.add,
                                      size: 40,
                                    ),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Image.file(_images![index]),
                                    Positioned(
                                      top: -14,
                                      right: -14,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.cancel,
                                          color:
                                              Get.theme.colorScheme.onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _images!.removeAt(index);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                            color: Get.theme.colorScheme.onSurface,
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
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    labelText: "Book Name",
                    controller: _bookNameController,
                  ),
                  CustomTextFormField(
                    labelText: "Description",
                    controller: _descriptionController,
                  ),
                  CustomTextFormField(
                    labelText: "Author",
                    controller: _authorController,
                  ),
                  // publisher
                  CustomTextFormField(
                    labelText: "Publisher",
                    controller: _publisherController,
                  ),
                  //                       Integer publicationYear;
                  CustomTextFormField(
                    labelText: "Publication Year",
                    controller: _publicationYearController,
                  ),
                  // Editable chip field
                  const EditableChipField(
                    list: Book_Genres,
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.local_pizza_rounded),
                      hintText: 'Search for genre',
                      labelText: 'Genre',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  // String isbn;
                  CustomTextFormField(
                      labelText: "ISBN", controller: _isbnController),
                  // Integer physicalPrice;
                  CustomTextFormField(
                      labelText: "Physical Price",
                      controller: _physicalPriceController),
                  // Integer digitalPrice;
                  CustomTextFormField(
                      labelText: "Digital Price",
                      controller: _digitalPriceController),
                  // String page;
                  CustomTextFormField(
                      labelText: "Page", controller: _pageController),
                  // String language;
                  CustomTextFormField(
                      labelText: "Language", controller: _languageController),
                  // String pdfUrl;
                  GestureDetector(
                    onTap: selectPdf,
                    child: DottedBorder(
                      color: Get.theme.colorScheme.onSurface,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.folder_open,
                              size: 40,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              pdf != null
                                  ? pdf!.path.split('/').last
                                  : "Select Book PDF file",
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

                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {},
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
        ));
  }
}
