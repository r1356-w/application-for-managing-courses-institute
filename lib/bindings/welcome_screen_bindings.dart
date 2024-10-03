import 'package:final_p/controllers/welcome_screen_controller.dart';
import 'package:get/get.dart';

class WelcomeScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<WelcomeScreenController>(WelcomeScreenController());
  }
}
