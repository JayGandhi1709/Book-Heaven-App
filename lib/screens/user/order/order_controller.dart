import 'dart:developer';

import 'package:book_heaven/models/api_response.dart';
import 'package:book_heaven/models/order_model.dart';
import 'package:book_heaven/models/user_model.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderController extends GetxController {
  final HttpService service = HttpService();

  OrderController(this.user);

  final String subUrl = 'orders';

  final UserModel user;

  final RxList<OrderModel> _allOrders = <OrderModel>[].obs;
  List<OrderModel> get allOrders => _allOrders;

  final RxList<OrderModel> _allEBooksOrders = <OrderModel>[].obs;
  List<OrderModel> get allEBooksOrders => _allEBooksOrders;

  final RxList<OrderModel> _allFilterOrders = <OrderModel>[].obs;
  List<OrderModel> get allFilterOrders => _allFilterOrders;

  final RxMap<String, double> _salesData = <String, double>{}.obs;
  Map<String, double> get salesData => _salesData;

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders({
    showSnack = false,
  }) async {
    try {
      Response response;
      if (user.role == "ADMIN") {
        response = await service.getMethod(endpointUrl: "admin/$subUrl");
      } else {
        response =
            await service.getByIdMethod(endpointUrl: subUrl, itemData: user.id);
      }
      log(response.isOk.toString());
      if (response.isOk) {
        ApiResponse<List<OrderModel>> apiResponse =
            ApiResponse<List<OrderModel>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => OrderModel.fromJson(item)).toList(),
        );
        log(apiResponse.data?.length.toString() ?? "");
        if (apiResponse.success == true) {
          _allOrders.assignAll(apiResponse.data ?? []);
          _allFilterOrders.assignAll(_allOrders);

          // filter ebooks orders
          if (user.role == "USER") {
            _allEBooksOrders.assignAll(_allOrders
                .where((order) => order.isDigitalOrder == true)
                .toList());
          }
          update();
          getSalesDataLast7Days();

          if (showSnack) {
            showSnackBar(apiResponse.message, MsgType.success);
          }
        } else {
          if (showSnack) {
            showSnackBar(
                "Failed to get : ${apiResponse.message}", MsgType.error);
          }
          log('Failed to get : ${apiResponse.message}');
        }
      } else {
        if (showSnack) {
          showSnackBar(
              "Error ${response.body?['message'] ?? response.statusText}",
              MsgType.error);
        }
        log("Error ${response.body?['message'] ?? response.statusText}");
      }
    } catch (e) {
      if (showSnack) {
        showSnackBar(
            "Something went wrong, please try again later.", MsgType.error);
      }
    }
  }

  Future<void> getAllUserOrders({
    showSnack = false,
    String? userId,
  }) async {
    try {
      final response = await service.getByIdMethod(
          endpointUrl: subUrl, itemData: userId ?? user.id);
      if (response.isOk) {
        ApiResponse<List<OrderModel>> apiResponse =
            ApiResponse<List<OrderModel>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => OrderModel.fromJson(item)).toList(),
        );
        if (apiResponse.success == true) {
          _allOrders.assignAll(apiResponse.data ?? []);
          _allFilterOrders.assignAll(_allOrders);
          // filter ebooks orders
          _allEBooksOrders.assignAll(_allOrders
              .where((order) => order.isDigitalOrder == true)
              .toList());
          update();

          if (showSnack) {
            showSnackBar(apiResponse.message, MsgType.success);
          }
        } else {
          if (showSnack) {
            showSnackBar(
                "Failed to get : ${apiResponse.message}", MsgType.error);
          }
          log('Failed to get : ${apiResponse.message}');
        }
      } else {
        if (showSnack) {
          showSnackBar(
              "Error ${response.body?['message'] ?? response.statusText}",
              MsgType.error);
        }
        log("Error ${response.body?['message'] ?? response.statusText}");
      }
    } catch (e) {
      if (showSnack) {
        showSnackBar(
            "Something went wrong, please try again later.", MsgType.error);
      }
    }
  }

  Future<void> placeOrder(
      {showSnack = false, required OrderModel order}) async {
    try {
      final response = await service.postMethod(
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
          if (showSnack) showSnackBar(apiResponse.message, MsgType.success);
          update();
          // await Future.delayed(
          //     const Duration(seconds: 2),
          //     () => Get.offAll(
          //         () => OrderDeatilsScreen(order: apiResponse.data!)));
        } else {
          if (showSnack) {
            showSnackBar(
                "Failed to Register : ${apiResponse.message}", MsgType.error);
          }
        }
      } else {
        if (showSnack) {
          showSnackBar(
              "Error ${response.body?['message'] ?? response.statusText}",
              MsgType.error);
        }
      }
    } catch (e) {
      log(e.toString());
      if (showSnack) {
        showSnackBar(
            "Something went wrong, please try again later.", MsgType.error);
      }
    }
  }

  Future<void> updateOrder(
      {showSnack = false, required OrderModel order}) async {
    try {
      final response = await service.putMethod(
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
          if (showSnack) showSnackBar(apiResponse.message, MsgType.success);
          update();
          // await Future.delayed(
          //     const Duration(seconds: 2),
          //     () => Get.offAll(
          //         () => OrderDeatilsScreen(order: apiResponse.data!)));
        } else {
          if (showSnack) {
            showSnackBar(
                "Failed to Register : ${apiResponse.message}", MsgType.error);
          }
        }
      } else {
        if (showSnack) {
          showSnackBar(
              "Error ${response.body?['message'] ?? response.statusText}",
              MsgType.error);
        }
      }
    } catch (e) {
      log(e.toString());
      if (showSnack) {
        showSnackBar(
            "Something went wrong, please try again later.", MsgType.error);
      }
    }
  }

  // update order status
  Future<void> updateOrderStatus(
      {showSnack = false,
      required OrderModel order,
      required String status}) async {
    try {
      final response = await service.putMethod(
        endpointUrl: "admin/$subUrl/${order.id}/status",
        itemData: status,
      );
      if (response.isOk) {
        ApiResponse<OrderModel> apiResponse = ApiResponse<OrderModel>.fromJson(
          response.body as Map<String, dynamic>,
          (json) => OrderModel.fromJson(json as Map<String, dynamic>),
        );
        if (apiResponse.success == true) {
          // replace the order with updated order
          var index =
              _allOrders.indexWhere((element) => element.id == order.id);
          _allOrders[index] = apiResponse.data!;
          index =
              _allFilterOrders.indexWhere((element) => element.id == order.id);
          _allFilterOrders[index] = apiResponse.data!;

          if (showSnack) {
            showSnackBar(apiResponse.message, MsgType.success);
          }
          update();
        } else {
          if (showSnack) {
            showSnackBar(
                "Failed to Register : ${apiResponse.message}", MsgType.error);
          }
        }
      } else {
        if (showSnack) {
          showSnackBar(
              "Error ${response.body?['message'] ?? response.statusText}",
              MsgType.error);
        }
      }
    } catch (e) {
      log(e.toString());
      if (showSnack) {
        showSnackBar(
            "Something went wrong, please try again later.", MsgType.error);
      }
    }
  }

  // filter orders
  void filterOrders({String? status, String? bookType}) {
    // Start with the complete list
    List<OrderModel> filteredOrders = _allOrders;

    // Filter by order status (ignore case), but only if status is provided and is not "All"
    if (status != null && status.isNotEmpty && status.toLowerCase() != 'all') {
      filteredOrders = filteredOrders
          .where((order) =>
              order.orderStatus.toLowerCase() == status.toLowerCase())
          .toList();
    }

    // Filter by book type if provided
    if (bookType != null && bookType.isNotEmpty) {
      switch (bookType) {
        case "E-Books":
          filteredOrders =
              filteredOrders.where((order) => order.isDigitalOrder).toList();
          break;
        case "Physical":
          filteredOrders =
              filteredOrders.where((order) => !order.isDigitalOrder).toList();
          break;
      }
    }

    // Update the filtered orders list and notify listeners
    _allFilterOrders.assignAll(filteredOrders);
    update();
  }

  // fulter orders by user id
  void filterOrdersByUserId({required String userID}) {
    // Start with the complete list
    List<OrderModel> filteredOrders = _allOrders;

    // Filter by user id
    filteredOrders =
        filteredOrders.where((order) => order.userId == userID).toList();

    // Update the filtered orders list and notify listeners
    _allFilterOrders.assignAll(filteredOrders);
    update();
  }

  double calculateTotalSelling() {
    double total = 0.0;

    for (var order in _allOrders) {
      // Assuming OrderModel has a property `price` for the order amount
      total +=
          order.totalPrice; // Replace `price` with the actual property name
    }

    return total;
  }

  void getSalesDataLast7Days() {
    Map<String, double> salesData = {};
    DateTime today = DateTime.now();

    try {
      // Initialize the sales data for the last 7 days
      for (int i = 0; i < 7; i++) {
        DateTime date = today.subtract(Duration(days: i));
        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
        salesData[formattedDate] = 0.0; // Initialize with 0
      }

      // Debug: Log existing orders
      for (var order in _allOrders) {
        log("Order Date: ${order.orderDate}, Total Price: ${order.totalPrice}");

        // Ensure the orderDate is in the correct format
        DateTime orderDate;
        try {
          orderDate = DateTime.parse(order.orderDate);
        } catch (e) {
          log("Error parsing order date: ${order.orderDate}");
          continue; // Skip if there's an error parsing the date
        }

        String formattedOrderDate = DateFormat('yyyy-MM-dd').format(orderDate);
        log("Formatted Order Date: $formattedOrderDate");

        log("${orderDate} ${formattedOrderDate} ${salesData.containsKey(formattedOrderDate)}",
            name: "date");

        // Check if the order is within the last 7 days
        if (salesData.containsKey(formattedOrderDate)) {
          log("comming", name: "com");
          salesData[formattedOrderDate] =
              salesData[formattedOrderDate]! + order.totalPrice;
          log("Updated Sales Data: $formattedOrderDate -> ${salesData[formattedOrderDate]}");
          log("Updated Sales Data value: ${salesData}");
        }
      }

      _salesData.addAll(salesData);
      update();
    } catch (e) {
      log("Error: $e");
    }
  }
}
