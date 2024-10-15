import 'dart:io';

import 'package:book_heaven/services/http_services.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BookController extends GetxController {
  HttpService httpService = HttpService();

  Future<void> addBook({
    required String id,
    required String title,
    required String desc,
    required List<File> img,
    required List<String> authors,
    required String publisher,
    required int publicationYear,
    required List<String> genre,
    required String isbn,
    required int physicalPrice,
    required int digitalPrice,
    required String page,
    required String language,
    required bool hasPhysicalCopy,
    required bool hasDigitalCopy,
    required File pdf,
  }) async {
    try {
      // Create form data
      final FormData formData = FormData({
        'id': id,
        'title': title,
        'desc': desc,
        // 'img': MultipartFile(img, filename: img.path.split('/').last),
        "img":
            img.map((e) => MultipartFile(e, filename: e.path.split('/').last)),
        'authors': authors,
        'publisher': publisher,
        'publicationYear':
            publicationYear.toString(), // Convert integer to string
        'genre': genre,
        'isbn': isbn,
        'physicalPrice': physicalPrice.toString(), // Convert integer to string
        'digitalPrice': digitalPrice.toString(), // Convert integer to string
        'page': page,
        'language': language,
        'hasPhysicalCopy':
            hasPhysicalCopy.toString(), // Convert boolean to string
        'hasDigitalCopy':
            hasDigitalCopy.toString(), // Convert boolean to string
        // 'pdfUrl': pdfUrl,
        'pdf': MultipartFile(pdf, filename: pdf.path.split('/').last),
      });

      // Make the API call
      final response = await httpService.post(
        endpointUrl: "admin/books",
        itemData: formData,
      );

      if (response.status.hasError) {
        throw Exception('Error: ${response.statusText}');
      } else {
        // print('Book added successfully');
        showSnackBar("Book added successfully!", MsgType.success);
        update();
      }
    } catch (e) {
      print('Runtime Error: $e');
    }
  }
}
