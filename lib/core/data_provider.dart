import 'package:book_heaven/models/api_response.dart';
import 'package:book_heaven/models/book.dart';
import 'package:book_heaven/models/carousel.dart';
import 'package:book_heaven/models/user.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:get/get.dart';

class DataProvider extends GetxController {
  HttpService httpService = HttpService();

  final RxList<Book> _allBooks = <Book>[].obs;
  List<Book> get allBooks => _allBooks.toList();

  final RxList<User> _allUsers = <User>[].obs;
  List<User> get allUsers => _allUsers.toList();

  final RxList<Carousel> _allCarousels = <Carousel>[].obs;
  List<Carousel> get allCarousels => _allCarousels;

  // DataProvider() {
  //   getAllBooks();
  //   getAllUsers();
  // }

  void onUserInit() {
    super.onInit();
    // getAllBooks();
    getAllCarousels();
  }

  void onAdminInit() {
    super.onInit();
    getAllBooks();
    getAllUsers();
    getAllCarousels();
  }

  // Future<List<Book>> getAllBooks({bool showSnake = false}) async {
  //   try {
  //     Response response = await httpService.get(endpointUrl: "admin/books");
  //     if (response.isOk) {
  //       ApiResponse<List<Book>> apiResponse = ApiResponse<List<Book>>.fromJson(
  //         response.body,
  //         (json) => (json as List).map((item) => Book.fromJson(item)).toList(),
  //       );
  //       _allBooks.assignAll(apiResponse.data ?? []);
  //     }
  //   } catch (e) {
  //     if (showSnake) {
  //       Get.snackbar("Error", e.toString());
  //     }
  //   }
  //   return _allBooks;
  // }

  Future<List<User>> getAllBooks({bool showSnake = false}) async {
    try {
      Response response = await httpService.get(endpointUrl: "admin/books");
      if (response.isOk) {
        ApiResponse<List<Book>> apiResponse = ApiResponse<List<Book>>.fromJson(
          response.body,
          (json) => (json as List).map((item) => Book.fromJson(item)).toList(),
        );

        if (apiResponse.success) {
          _allBooks.assignAll(apiResponse.data ?? []);
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

  Future<List<User>> getAllUsers({bool showSnake = false}) async {
    try {
      Response response = await httpService.get(endpointUrl: "admin/users");
      if (response.isOk) {
        ApiResponse<List<User>> apiResponse = ApiResponse<List<User>>.fromJson(
          response.body,
          (json) => (json as List).map((item) => User.fromJson(item)).toList(),
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

  Future<List<Carousel>> getAllCarousels({bool showSnake = false}) async {
    try {
      Response response = await httpService.get(endpointUrl: "carousel");
      if (response.isOk) {
        ApiResponse<List<Carousel>> apiResponse =
            ApiResponse<List<Carousel>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Carousel.fromJson(item)).toList(),
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
