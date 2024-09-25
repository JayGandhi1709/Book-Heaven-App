import 'dart:developer';
import 'dart:io';

import 'package:book_heaven/core/data_provider.dart';
import 'package:book_heaven/models/api_response.dart';
import 'package:book_heaven/models/carousel.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:get/get.dart';

class CarouselServices extends GetxController {
  final DataProvider _dataProvider;
  HttpService service = HttpService();

  CarouselServices(this._dataProvider);

  String subUrl = 'admin/carousel';

  Future<void> addCarousel(
      File image, String title, String description, int order) async {
    try {
      final FormData formData = FormData({
        'image': MultipartFile(image, filename: image.path.split('/').last),
        "title": title,
        "description": description,
      });

      final response = await service.post(
        endpointUrl: subUrl,
        itemData: formData,
      );

      if (response.isOk) {
        ApiResponse apiResponse =
            ApiResponse.fromJson(response.body, (json) => null);

        if (apiResponse.success) {
          await _dataProvider.getAllCarousels();
          Get.back();
          showSnackBar(apiResponse.message, MsgType.success);
        } else {
          showSnackBar(apiResponse.message, MsgType.error);
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

  // delete carousel from database
  Future<void> deleteCarousel(String id) async {
    try {
      final response = await service.delete(
        endpointUrl: subUrl,
        itemId: id,
      );
      if (response.isOk) {
        ApiResponse apiResponse =
            ApiResponse.fromJson(response.body, (json) => null);

        if (apiResponse.success) {
          Get.back();
          _dataProvider.getAllCarousels(showSnake: true);
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

  // update carousel order in database
  Future<void> updateCarouselOrder(List<Carousel> carousels) async {
    try {
      List<Map<String, dynamic>> carouselList = carousels
          .map((carousel) => {
                "id": carousel.id,
                "displayOrder": carousels.indexOf(carousel),
              })
          .toList();

      final response = await service.put(
        endpointUrl: "$subUrl/update-display-order",
        itemData: carouselList,
      );
      if (response.isOk) {
        ApiResponse apiResponse =
            ApiResponse.fromJson(response.body, (json) => null);

        if (apiResponse.success) {
          await _dataProvider.getAllCarousels();
          showSnackBar(apiResponse.message, MsgType.success);
        } else {
          showSnackBar(apiResponse.message, MsgType.error);
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

  // update carousel in database
  Future<void> updateCarousel(Carousel carousel) async {
    try {
      final FormData formData = FormData({
        "title": carousel.title,
        "description": carousel.description,
      });

      final response = await service.putById(
        endpointUrl: subUrl,
        itemData: formData,
        itemId: carousel.id,
      );
      if (response.isOk) {
        ApiResponse apiResponse =
            ApiResponse.fromJson(response.body, (json) => null);

        if (apiResponse.success) {
          Get.back();
          await _dataProvider.getAllCarousels();
          showSnackBar(apiResponse.message, MsgType.success);
        } else {
          showSnackBar(apiResponse.message, MsgType.error);
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
