import 'package:final_p/controllers/view_screen_controller.dart';
import 'package:get/get.dart';

class ViewScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ViewScreenController>(ViewScreenController());
  }
}
