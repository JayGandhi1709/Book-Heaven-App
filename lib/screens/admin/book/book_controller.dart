import 'package:book_heaven/services/http_services.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BookController extends GetxController {
  HttpService httpService = HttpService();

  Future<void> addBook({
    required String id,
    required String title,
    required String desc,
    required List<String> img,
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
    required String pdfUrl,
  }) async {
    try {
      // Create form data
      final FormData formData = FormData({
        'id': id,
        'title': title,
        'desc': desc,
        'img': img, // Assuming img is an array of image URLs or paths
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
        'pdfUrl': pdfUrl,
      });

      // Make the API call
      final response = await httpService.post(
          endpointUrl: "admin/books", itemData: formData);

      if (response.status.hasError) {
        throw Exception('Error: ${response.statusText}');
      } else {
        print('Book added successfully');
      }
    } catch (e) {
      print('Runtime Error: $e');
    }
  }
}
