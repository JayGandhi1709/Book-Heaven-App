import 'dart:developer';

import 'package:book_heaven/screens/admin/dashboard/dashboard_screen.dart';
import 'package:book_heaven/screens/main_home_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:book_heaven/models/api_response.dart';
import 'package:book_heaven/models/user_model.dart';
import 'package:book_heaven/screens/auth/log_in_screen.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:book_heaven/utility/constants.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';

class UserController extends GetxController {
  var isLoggedIn = false.obs;
  HttpService service = HttpService();
  SharedPreferences? prefs;
  String token = "";
  UserModel _user = UserModel(
    id: '',
    name: '',
    email: '',
    password: '',
    role: '',
  );
  UserModel get user => _user;

  // final sub_url = 'customer';
  final String subUrl = 'auth';

  void setUser(String user) {
    _user = UserModel.fromJson(user as Map<String, dynamic>);
    update();
  }

  void setUserFromModel(UserModel user) {
    _user = user;
    update();
  }

  void clearUser() {
    _user = UserModel(
      id: '',
      name: '',
      email: '',
      password: '',
      role: '',
    );
    update();
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      Map<String, dynamic> loginData = {
        "email": email.toLowerCase(),
        "password": password,
      };
      final response = await service.post(
        endpointUrl: '$subUrl/login',
        itemData: loginData,
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(
            response.body,
            //   (json) => json,
            // );
            (json) => {
                  "user": UserModel.fromJson((json
                      as Map<String, dynamic>)['user'] as Map<String, dynamic>),
                  "token": json['token'],
                  "data": json,
                });

        if (apiResponse.success == true) {
          log("message: ${apiResponse.data['user']}");
          setUserFromModel(await apiResponse.data['user']);
          token = await apiResponse.data['token'];
          if (token.isNotEmpty) {
            saveToken(token);
          } else {
            showSnackBar("Something Went Wrong!", MsgType.error);
            return true;
          }
          showSnackBar(apiResponse.message, MsgType.success);
          log("Login Successful");
          // await Get.off(() => const MainHomeScreen());
          await Get.off(() => _user.role == 'ADMIN'
              ? const DashboardScreen()
              : const MainHomeScreen());
          isLoggedIn.value = true;
          return true;
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
      print("Error: $e");
      showSnackBar("An error occurred: $e", MsgType.error);
      // return "An error occurred: $e";
    }
    return false;
  }

  Future<String?> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      Map<String, dynamic> user = {
        "name": name.toLowerCase(),
        "email": email.toLowerCase(),
        "password": password,
      };

      final response = await service.post(
        // endpointUrl: '$sub_url/register',
        endpointUrl: subUrl,
        itemData: user,
      );

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          log(apiResponse.message);
          showSnackBar(apiResponse.message, MsgType.success);
          log("Register Successful");
          return "Register Successful";
        } else {
          showSnackBar(
              "Failed to Register : ${apiResponse.message}", MsgType.error);
          log('Failed to Register : ${apiResponse.message}');
          return 'Failed to Register : ${apiResponse.message}';
        }
      } else {
        showSnackBar(
            "Error ${response.body?['message'] ?? response.statusText}",
            MsgType.error);
        log("Error ${response.body?['message'] ?? response.statusText}");
        return "Error ${response.body?['message'] ?? response.statusText}";
      }
    } catch (e) {
      print(e);
      showSnackBar("An error occurred: $e", MsgType.error);
      log("An error occurred: $e");
      return "An error occurred: $e";
    }
  }

  void saveToken(String token) async {
    // write a code to store token in shared preference
    prefs = await SharedPreferences.getInstance();
    await prefs?.setString(USER_TOKEN, token);
  }

  Future<bool> getLoginUsr() async {
    try {
      prefs = await SharedPreferences.getInstance();
      token = prefs?.getString(USER_TOKEN) ?? "";
      final response = await service.get(
        endpointUrl: '$subUrl/tokenIsValid',
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(
          response.body,
          //   (json) => json,
          // );
          (json) => UserModel.fromJson(json as Map<String, dynamic>),
        );

        if (apiResponse.success == true) {
          log("message: ${apiResponse.data}");
          setUserFromModel(apiResponse.data);
          // showSnackBar(apiResponse.message, MsgType.success);
          log("Welcome Back");
          // loginUser.toJson().isNotEmpty
          //     ? await Get.off(() => const HomeScreen())
          //     : await Get.off(() => const LoginScreen());
          // await Get.off(
          //   () => _user.role == "ADMIN"
          //       ? const AdminScreen()
          //       : const MainHomeScreen(),
          // );
          return true;
        } else {
          // showSnackBar(
          // "Failed to Register : ${apiResponse.message}", MsgType.error);
          // return 'Failed to Register : ${apiResponse.message}';
        }
      } else {
        // showSnackBar(
        //     "Error ${response.body?['message'] ?? response.statusText}",
        //     MsgType.error);
        // return "Error ${response.body?['message'] ?? response.statusText}";
      }
    } catch (e) {
      print("Error: $e");
      // showSnackBar("An error occurred: $e", MsgType.error);
      // return "An error occurred: $e";
    }
    return false;
  }

  void logOutUser() async {
    clearUser();
    prefs = await SharedPreferences.getInstance();
    prefs?.remove(USER_TOKEN);
    Get.offAll(() => const LoginScreen());
  }

  @override
  void onInit() async {
    super.onInit();
    isLoggedIn.value = await getLoginUsr();
  }
}
