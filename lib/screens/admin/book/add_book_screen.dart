import 'dart:developer';
import 'dart:io';

import 'package:book_heaven/common/custom_text_form_field.dart';
import 'package:book_heaven/utility/extensions.dart';
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
  bool _isLoading = false;

  // controllers
  final List<File> _images = <File>[];

  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _publicationYearController =
      TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _physicalPriceController =
      TextEditingController();
  final TextEditingController _digitalPriceController = TextEditingController();
  final TextEditingController _pageController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  // TextEditingController _pdfUrlController = TextEditingController();
  File? pdf;
  // final List<String> _genreController = [];

  void selectImages() async {
    List<File> image = await pickMultipleImages();
    if (image.isNotEmpty) {
      setState(() {
        _images.addAll(image);
      });
    }
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
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _images.isNotEmpty
                      ? SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _images.length + 1,
                            itemBuilder: (context, index) {
                              if (index == _images.length) {
                                return GestureDetector(
                                  onTap: selectImages,
                                  child: Container(
                                    width: 100,
                                    height: 150,
                                    color: Get.theme.colorScheme.onSurface,
                                    child: Icon(
                                      Icons.add,
                                      color: Get.theme.colorScheme.surface,
                                      size: 40,
                                    ),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Image.file(_images[index]),
                                    Positioned(
                                      top: -14,
                                      right: -14,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Get.theme.colorScheme.surface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _images.removeAt(index);
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
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFormField(
                    labelText: "Genre",
                    controller: _genreController,
                  ),
                  // Editable chip field
                  // EditableChipField(
                  //   list: Book_Genres,
                  //   onChanged: (List<String> value){
                  //     log("onChange");
                  //     setState(() {
                  //       _genreController.addAll(value);
                  //     });
                  //     log(_genreController.toString(),name:"category");
                  //   },
                  //   decoration: const InputDecoration(
                  //     // prefixIcon: Icon(Icons.local_pizza_rounded),
                  //     hintText: 'Search for genre',
                  //     labelText: 'Genre',
                  //     border: OutlineInputBorder(),
                  //   ),
                  // ),

                  // String isbn;
                  CustomTextFormField(
                      labelText: "ISBN", controller: _isbnController),
                  // Integer physicalPrice;
                  CustomTextFormField(
                    labelText: "Physical Price",
                    controller: _physicalPriceController,
                    keyboardType: TextInputType.number,
                  ),
                  // Integer digitalPrice;
                  CustomTextFormField(
                    labelText: "Digital Price",
                    keyboardType: TextInputType.number,
                    controller: _digitalPriceController,
                  ),
                  // String page;
                  CustomTextFormField(
                    keyboardType: TextInputType.number,
                    labelText: "Page",
                    controller: _pageController,
                  ),
                  // String language;
                  CustomTextFormField(
                      labelText: "Language", controller: _languageController),
                  // String pdfUrl;
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: selectPdf,
                      child: DottedBorder(
                        color: Get.theme.colorScheme.onSurface,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(width: 10),
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
                    ),
                  ),

                  const SizedBox(height: 30),
                  _isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            context.bookController.addBook(
                              title: _bookNameController.text,
                              desc: _descriptionController.text,
                              img: _images,
                              authors: _authorController.text.split(","),
                              publisher: _publisherController.text,
                              publicationYear:
                                  int.parse(_publicationYearController.text),
                              genre: _genreController.text.split(","),
                              isbn: _isbnController.text,
                              physicalPrice:
                                  int.parse(_physicalPriceController.text),
                              digitalPrice:
                                  int.parse(_digitalPriceController.text),
                              page: _pageController.text,
                              language: _languageController.text,
                              hasPhysicalCopy:
                                  _physicalPriceController.text.isNotEmpty,
                              hasDigitalCopy: pdf == null ? false : true,
                              pdf: pdf!,
                            );

                            setState(() {
                              _isLoading = false;
                            });
                          },
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
