import 'package:book_heaven/models/api_response.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:book_heaven/utility/show_snack_bar.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashboardProvider extends GetxController {
  HttpService service = HttpService();
  final subUrl = 'admin';

  void count() async {
    try {
      final response = await service.get(
        endpointUrl: '$subUrl/counts',
      );
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(
          response.body,
          (json) => json,
        );

        if (response.isOk) {
          print(apiResponse.data);
        } else {
          showSnackBar("Failed : ${apiResponse.message}", MsgType.error);
        }
      } else {
        showSnackBar(
            "Error ${response.body?['message'] ?? response.statusText}",
            MsgType.error);
      }
    } catch (e) {
      showSnackBar("An error occurred: $e", MsgType.error);
    }
  }
}
