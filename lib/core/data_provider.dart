import 'dart:developer';

import 'package:book_heaven/models/api_response.dart';
import 'package:book_heaven/models/book.dart';
import 'package:book_heaven/models/user.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:get/get.dart';

class DataProvider extends GetxController {
  HttpService httpService = HttpService();

  List<Book> _allBooks = [];
  List<Book> get allBooks => _allBooks;

  List<User> _allUsers = [];
  List<User> get allUsers => _allUsers;

  DataProvider() {
    getAllBooks();
    getAllUsers();
  }

  Future<List<Book>> getAllBooks({bool showSnake = false}) async {
    try {
      Response response = await httpService.get(endpointUrl: "admin/books");
      if (response.isOk) {
        ApiResponse<List<Book>> apiResponse = ApiResponse<List<Book>>.fromJson(
          response.body,
          (json) => (json as List).map((item) => Book.fromJson(item)).toList(),
        );
        _allBooks = apiResponse.data ?? [];
      }
    } catch (e) {
      if (showSnake) {
        Get.snackbar("Error", e.toString());
      }
    }
    return _allBooks;
  }

  Future<List<User>> getAllUsers({bool showSnake = false}) async {
    try {
      Response response = await httpService.get(endpointUrl: "admin/users");
      if (response.isOk) {
        ApiResponse<List<User>> apiResponse = ApiResponse<List<User>>.fromJson(
          response.body,
          // (json) => (json as List).map((item) => User.fromJson(item)).toList(),
          (json) => (json as List)
              .map((item) => User.fromJson(item as Map<String, dynamic>))
              .toList(),
        );

        // List<User> users =
        //     (response.body as List).map((item) => User.fromJson(item)).toList();

        if (apiResponse.success) {
          _allUsers = apiResponse.data ?? [];
          // notifyListeners();
          // _allUsers = users;
          update();
          showSnake ? showSnackBar("Fetched all users", MsgType.success) : null;
          // showSnake ? showSnackBar("Fetched all users", MsgType.success) : null;
        } else {
          // showSnake
          //     ? showSnackBar(
          //         "Failed to fetch : ${apiResponse.message}", MsgType.error)
          //     : null;
        }
      } else {
        showSnake
            ? showSnackBar(
                "Error ${response.body?['message'] ?? response.statusText}",
                MsgType.error)
            : null;
      }
    } catch (e) {
      print(e);
      if (showSnake) {
        // Get.snackbar("Error", e.toString());
        showSnackBar(e.toString(), MsgType.error);
      }
      showSnackBar(e.toString(), MsgType.error);
    }
    return _allUsers;
  }
}
