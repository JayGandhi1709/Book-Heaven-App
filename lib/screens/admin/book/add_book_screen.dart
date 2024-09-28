import 'package:book_heaven/common/custom_text_form_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

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
  // File? _image;

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
                  DottedBorder(
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
                  const SizedBox(height: 10),
                  const CustomTextFormField(labelText: "Book Name"),
                  const CustomTextFormField(labelText: "Description"),
                  const CustomTextFormField(labelText: "Author"),
                  // publisher
                  const CustomTextFormField(labelText: "Publisher"),
                  //                       Integer publicationYear;
                  const CustomTextFormField(labelText: "Publication Year"),
                  // List<String> genre;
                  const CustomTextFormField(labelText: "Genre"),
                  // String isbn;
                  const CustomTextFormField(labelText: "ISBN"),
                  // Integer physicalPrice;
                  const CustomTextFormField(labelText: "Physical Price"),
                  // Integer digitalPrice;
                  const CustomTextFormField(labelText: "Digital Price"),
                  // String page;
                  const CustomTextFormField(labelText: "Page"),
                  // String language;
                  const CustomTextFormField(labelText: "Language"),
                  // String pdfUrl;
                  const CustomTextFormField(labelText: "PDF URL"),
                  const SizedBox(height: 20),
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
