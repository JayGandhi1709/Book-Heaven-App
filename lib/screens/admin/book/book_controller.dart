import 'dart:developer';
import 'dart:io';

import 'package:book_heaven/models/api_response.dart';
import 'package:book_heaven/models/book_model.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:book_heaven/utility/extensions.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BookController extends GetxController {
  HttpService httpService = HttpService();

  Future<void> addBook({
    required String title,
    required String desc,
    required List<String> authors,
    required String publisher,
    required List<String> genre,
    required List<File> img,
    required String isbn,
    required int publicationYear,
    required String page,
    required int physicalPrice,
    required int digitalPrice,
    required bool hasPhysicalCopy,
    required bool hasDigitalCopy,
    required String language,
    required File pdf,
  }) async {
    try {

      log(img.length.toString());

      final List<MultipartFile> imgFiles = await Future.wait(img.map((file) async {
        return await MultipartFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: "image/jpeg",
        );
      }));
      // Create form data
      final FormData formData = FormData({
        'title': title,
        'desc': desc,
        "img":imgFiles,
            // img.map((e) => MultipartFile(e, filename: e.path.split('/').last)),
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
        'hasPhysicalCopy': hasPhysicalCopy, // Convert boolean to string
        'hasDigitalCopy': hasDigitalCopy, // Convert boolean to string
        // 'pdfUrl': pdfUrl,
        'pdf': MultipartFile(pdf, filename: pdf.path.split('/').last,contentType: "application/pdf"),
      });

      log(genre.toString());

      log(formData.fields.toString(), name: "add Book Log");

      // Make the API call
      final response = await httpService.post(
        endpointUrl: "admin/books",
        itemData: formData,
      );
      log(response.body.toString(), name: "add Book Log");
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(
          response.body,
          (json)=>BookModel.fromJson(json as Map<String,dynamic>),
        );

        if (apiResponse.success == true) {
          showSnackBar("Book added Successfully", MsgType.success);
          Get.context!.dataProvider.allBooks.add(apiResponse.data);
          update();
        } else {
          showSnackBar(
              "Failed to Register : ${apiResponse.message}", MsgType.error);
          // return 'Failed to Register : ${apiResponse.message}';
        }
      } else {
        showSnackBar(
            "Error ${response.body?['message'] ?? response.statusText}",
            MsgType.error);
        // return "Error ${response.body?['message'] ?? response.statusText}";
      }
    } catch (e) {
      print('Runtime Error: $e');
    }
  }

  // delete carousel from database
  Future<void> deleteBook(String id) async {
    try {
      final response = await httpService.delete(
        endpointUrl: "admin/books",
        itemId: id,
      );
      if (response.isOk) {
        ApiResponse apiResponse =
        ApiResponse.fromJson(response.body, (json) => null);

        if (apiResponse.success) {
          Get.back();
          await Get.context!.dataProvider.getAllBooks();
          showSnackBar(apiResponse.message, MsgType.success);
        } else {
          showSnackBar(apiResponse.data, MsgType.error);
        }
      } else {
        log("Error ${response.body?['message'] ?? response.statusText}");
        showSnackBar(
            "Error ${response.body?['message'] ?? response.statusText}",
            MsgType.error);
        // return "Error ${response.body?['message'] ?? response.statusText}";
      }
    } catch (e) {
      print("Error: $e");
      showSnackBar("An error occurred: $e", MsgType.error);
      // return "An error occurred: $e";
    }
  }

}
