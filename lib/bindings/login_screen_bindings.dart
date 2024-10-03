import 'package:final_p/controllers/login_screen_controller.dart';
import 'package:get/get.dart';

class LoginScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginScreenController>(
      LoginScreenController(),
    );
  }
}
