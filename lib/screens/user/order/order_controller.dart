import 'dart:convert';
import 'dart:developer';

import 'package:book_heaven/models/api_response.dart';
import 'package:book_heaven/models/order_model.dart';
import 'package:book_heaven/screens/user/order/order_details_screen.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final HttpService service = HttpService();

  OrderController(this.userID);

  final String subUrl = 'orders';

  final String userID;

  final RxList<OrderModel> _allOrders = <OrderModel>[].obs;
  List<OrderModel> get allOrders => _allOrders;

  final RxList<OrderModel> _allEBooksOrders = <OrderModel>[].obs;
  List<OrderModel> get allEBooksOrders => _allEBooksOrders;

  @override
  void onInit() {
    super.onInit();
    getAllUserOrders();
  }

  // get all orders of a user
  Future<void> getAllUserOrders({
    showSnakebar = false,
  }) async {
    try {
      final response =
          await service.getById(endpointUrl: subUrl, itemData: userID);
      if (response.isOk) {
        ApiResponse<List<OrderModel>> apiResponse =
            ApiResponse<List<OrderModel>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => OrderModel.fromJson(item)).toList(),
        );
        if (apiResponse.success == true) {
          _allOrders.assignAll(apiResponse.data ?? []);
          // filter ebooks orders
          _allEBooksOrders.assignAll(_allOrders
              .where((order) => order.isDigitalOrder == true)
              .toList());
          update();

          if (showSnakebar) {
            showSnackBar(apiResponse.message, MsgType.success);
          }
        } else {
          if (showSnakebar) {
            showSnackBar(
                "Failed to get : ${apiResponse.message}", MsgType.error);
          }
          log('Failed to get : ${apiResponse.message}');
        }
      } else {
        if (showSnakebar) {
          showSnackBar(
              "Error ${response.body?['message'] ?? response.statusText}",
              MsgType.error);
        }
        log("Error ${response.body?['message'] ?? response.statusText}");
      }
    } catch (e) {
      if (showSnakebar) {
        showSnackBar(
            "Something went wrong, please try again later.", MsgType.error);
      }
    }
  }

  Future<void> placeOrder(
      {showSnackBar = false, required OrderModel order}) async {
    try {
      log(jsonEncode(order.toJson()));
      log(order.deliveryAddress);
      final response = await service.post(
        endpointUrl: subUrl,
        itemData: order.toJson(),
      );
      if (response.isOk) {
        ApiResponse<OrderModel> apiResponse = ApiResponse<OrderModel>.fromJson(
          response.body as Map<String, dynamic>,
          (json) => OrderModel.fromJson(json as Map<String, dynamic>),
        );
        if (apiResponse.success == true) {
          log(apiResponse.message);
          if (showSnackBar) showSnackBar(apiResponse.message, MsgType.success);
          update();
          // await Future.delayed(
          //     const Duration(seconds: 2),
          //     () => Get.offAll(
          //         () => OrderDeatilsScreen(order: apiResponse.data!)));
        } else {
          if (showSnackBar)
            showSnackBar(
                "Failed to Register : ${apiResponse.message}", MsgType.error);
        }
      } else {
        if (showSnackBar)
          showSnackBar(
              "Error ${response.body?['message'] ?? response.statusText}",
              MsgType.error);
      }
    } catch (e) {
      log(e.toString());
      if (showSnackBar)
        showSnackBar(
            "Something went wrong, please try again later.", MsgType.error);
    }
  }
}
