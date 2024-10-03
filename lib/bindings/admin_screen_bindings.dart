import 'package:final_p/controllers/admin_screen_controller.dart';
import 'package:get/get.dart';

class AdminScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<AdminScreenController>(
      AdminScreenController(),
    );
  }
}
