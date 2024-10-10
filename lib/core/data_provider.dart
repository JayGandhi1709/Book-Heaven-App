import 'dart:developer';

import 'package:book_heaven/common/banner_carousel.dart';
import 'package:book_heaven/models/address.dart';
import 'package:book_heaven/models/api_response.dart';
import 'package:book_heaven/models/book_model.dart';
import 'package:book_heaven/models/carousel_model.dart';
import 'package:book_heaven/models/user_model.dart';
import 'package:book_heaven/screens/auth/log_in_screen.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:get/get.dart';

class DataProvider extends GetxController {
  HttpService httpService = HttpService();

  final RxList<BookModel> _allBooks = <BookModel>[].obs;
  List<BookModel> get allBooks => _allBooks;

  final RxList<BookModel> _filterBook = <BookModel>[].obs;
  List<BookModel> get filterBook => _filterBook;

  final RxList<UserModel> _allUsers = <UserModel>[].obs;
  List<UserModel> get allUsers => _allUsers;

  final RxList<CarouselModel> _allCarousels = <CarouselModel>[].obs;
  List<CarouselModel> get allCarousels => _allCarousels;

  void onUserInit() {
    super.onInit();
    getAllBooks();
    getAllCarousels();
  }

  void onAdminInit() {
    super.onInit();
    getAllBooks();
    getAllUsers();
    getAllCarousels();
  }

  Future<List<UserModel>> getAllBooks({bool showSnake = false}) async {
    try {
      Response response = await httpService.get(endpointUrl: "books");
      if (response.isOk) {
        ApiResponse<List<BookModel>> apiResponse =
            ApiResponse<List<BookModel>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => BookModel.fromJson(item)).toList(),
        );

        if (apiResponse.success) {
          _allBooks.assignAll(apiResponse.data ?? []);
          _filterBook.assignAll(apiResponse.data ?? []);

          showSnake ? showSnackBar("Fetched all users", MsgType.success) : null;
        } else {
          showSnake
              ? showSnackBar(
                  "Failed to fetch : ${apiResponse.message}", MsgType.error)
              : null;
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
        showSnackBar("Error : ${e.toString()}", MsgType.error);
      }
      showSnackBar(e.toString(), MsgType.error);
    }
    return _allUsers;
  }

  List<BookModel> filterBooks(String query) {
    if (query.isEmpty) {
      return _allBooks;
    }
    log(_allBooks
        .where((book) => book.title.toLowerCase().contains(query.toLowerCase()))
        .toList()
        .toString());
    return _allBooks
        .where((book) => book.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<UserModel>> getAllUsers({bool showSnake = false}) async {
    try {
      Response response = await httpService.get(endpointUrl: "admin/users");
      if (response.isOk) {
        ApiResponse<List<UserModel>> apiResponse =
            ApiResponse<List<UserModel>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => UserModel.fromJson(item)).toList(),
        );

        if (apiResponse.success) {
          _allUsers.assignAll(apiResponse.data ?? []);
          showSnake ? showSnackBar("Fetched all users", MsgType.success) : null;
        } else {
          showSnake
              ? showSnackBar(
                  "Failed to fetch : ${apiResponse.message}", MsgType.error)
              : null;
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
        showSnackBar("Error : ${e.toString()}", MsgType.error);
      }
      showSnackBar(e.toString(), MsgType.error);
    }
    return _allUsers;
  }

  Future<List<CarouselModel>> getAllCarousels({bool showSnake = false}) async {
    try {
      Response response = await httpService.get(endpointUrl: "carousel");
      if (response.isOk) {
        ApiResponse<List<CarouselModel>> apiResponse =
            ApiResponse<List<CarouselModel>>.fromJson(
          response.body,
          (json) => (json as List)
              .map((item) => CarouselModel.fromJson(item))
              .toList(),
        );

        if (apiResponse.success) {
          _allCarousels.assignAll(apiResponse.data ?? []);
          showSnake
              ? showSnackBar("Fetched all Carousels", MsgType.success)
              : null;
        } else {
          showSnake
              ? showSnackBar(
                  "Failed to fetch : ${apiResponse.message}", MsgType.error)
              : null;
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
        showSnackBar("Error : ${e.toString()}", MsgType.error);
      }
      showSnackBar(e.toString(), MsgType.error);
    }
    return _allCarousels;
  }
}
