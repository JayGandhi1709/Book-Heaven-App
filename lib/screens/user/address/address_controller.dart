import 'dart:convert';
import 'dart:developer';
import 'package:book_heaven/models/address_model.dart';
import 'package:book_heaven/models/api_response.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  final HttpService service = HttpService();
  AddressController(this.userID);

  final String subUrl = 'address';

  final String userID;

  final RxList<AddressModel> _allAddress = <AddressModel>[].obs;
  List<AddressModel> get allAddress => _allAddress;

  @override
  void onInit() {
    super.onInit();
    getAllAddress(userID: userID);
  }

  Future<List<AddressModel>> getAllAddress(
      {bool showSnack = false, required String userID}) async {
    try {
      Response response = await service.getById(
        endpointUrl: "address/user",
        itemData: userID,
      );
      if (response.isOk) {
        ApiResponse<List<AddressModel>> apiResponse =
            ApiResponse<List<AddressModel>>.fromJson(
          response.body,
          (json) => (json as List)
              .map((item) => AddressModel.fromJson(item))
              .toList(),
        );

        if (apiResponse.success) {
          _allAddress.assignAll(apiResponse.data ?? []);
          update();
          showSnack
              ? showSnackBar("Fetched all address", MsgType.success)
              : null;
        } else {
          showSnack
              ? showSnackBar(
                  "Failed to fetch : ${apiResponse.message}", MsgType.error)
              : null;
        }
      } else {
        showSnack
            ? showSnackBar(
                "Error ${response.body?['message'] ?? response.statusText}",
                MsgType.error)
            : null;
      }
    } catch (e) {
      print(e);
      if (showSnack) {
        showSnackBar("Error : ${e.toString()}", MsgType.error);
      }
      showSnackBar(e.toString(), MsgType.error);
    }
    return _allAddress;
  }

  Future<String?> addAddress(AddressModel address) async {
    try {
      final response = await service.post(
        endpointUrl: subUrl,
        itemData: address.toJson(),
      );

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(
          response.body,
          (json) => AddressModel.fromJson(json as Map<String, dynamic>),
        );
        if (apiResponse.success == true) {
          // log(apiResponse.message);
          _allAddress.add(apiResponse.data);
          // log(apiResponse.data);
          showSnackBar(apiResponse.message, MsgType.success);
          log("Address Added Successful");
          update();
          return "Address Added Successful";
        } else {
          showSnackBar("Failed to add : ${apiResponse.message}", MsgType.error);
          log('Failed to Regaddister : ${apiResponse.message}');
          return 'Failed to add : ${apiResponse.message}';
        }
      } else {
        showSnackBar(
            "Error ${response.body?['message'] ?? response.statusText}",
            MsgType.error);
        log("Error ${response.body?['message'] ?? response.statusText}");
        return "Error ${response.body?['message'] ?? response.statusText}";
      }
    } catch (e) {
      showSnackBar("An error occurred: $e", MsgType.error);
      log("An error occurred: $e");
      return "An error occurred: $e";
    }
  }

  // update address
  Future<String?> updateAddress(AddressModel address) async {
    try {
      log(address.toJson().toString());
      final response = await service.putById(
        endpointUrl: subUrl,
        itemId: address.id!,
        itemData: address.toJson(),
      );

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(
          response.body,
          (json) => AddressModel.fromJson(json as Map<String, dynamic>),
        );
        if (apiResponse.success == true) {
          _allAddress[_allAddress.indexWhere(
              (element) => element.id == address.id)] = apiResponse.data;
          update();
          showSnackBar(apiResponse.message, MsgType.success);
          log("Address Updated Successful");
          return "Address Updated Successful";
        } else {
          showSnackBar(
              "Failed to update : ${apiResponse.message}", MsgType.error);
          log('Failed to update : ${apiResponse.message}');
          return 'Failed to update : ${apiResponse.message}';
        }
      } else {
        showSnackBar(
            "Error ${response.body?['message'] ?? response.statusText}",
            MsgType.error);
        log("Error ${response.body?['message'] ?? response.statusText}");
        return "Error ${response.body?['message'] ?? response.statusText}";
      }
    } catch (e) {
      showSnackBar("An error occurred: $e", MsgType.error);
      log("An error occurred: $e");
      return "An error occurred: $e";
    }
  }

  // delete
  Future<String?> deleteAddress(String id) async {
    try {
      final response = await service.delete(
        endpointUrl: subUrl,
        itemId: id,
      );

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          // log(apiResponse.message);
          showSnackBar(apiResponse.message, MsgType.success);
          _allAddress.removeWhere((element) => element.id == id);
          update();
          log("Address Deleted Successful");
          return "Address Deleted Successful";
        } else {
          showSnackBar(
              "Failed to delete : ${apiResponse.message}", MsgType.error);
          log('Failed to delete : ${apiResponse.message}');
          return 'Failed to delete : ${apiResponse.message}';
        }
      } else {
        showSnackBar(
            "Error ${response.body?['message'] ?? response.statusText}",
            MsgType.error);
        log("Error ${response.body?['message'] ?? response.statusText}");
        return "Error ${response.body?['message'] ?? response.statusText}";
      }
    } catch (e) {
      showSnackBar("An error occurred: $e", MsgType.error);
      log("An error occurred: $e");
      return "An error occurred: $e";
    }
  }
}
