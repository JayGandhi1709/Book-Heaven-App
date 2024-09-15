import 'dart:developer';
import 'dart:io';

import 'package:book_heaven/models/api_response.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:get/get.dart';

class CarouselServices {
  HttpService service = HttpService();

  String subUrl = 'admin/carousel';

  Future<void> addCarousel(
      File image, String title, String description, int order) async {
    // add carousel to database
    try {
      // print order datatype
      log("order: ${order.runtimeType}");
      Map<String, dynamic> data = {
        'image': image,
        "title": title,
        "description": description,
        "displayOrder": int.parse(order.toString()),
      };
      log(data.toString());
      final response = await service.post(
        endpointUrl: subUrl,
        itemData: data,
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          log("message: ${apiResponse.data}");
          Get.back();
        } else {
          showSnackBar(apiResponse.data, MsgType.error);
        }
      } else {
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
