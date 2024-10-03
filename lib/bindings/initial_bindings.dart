import 'package:final_p/services/app_service.dart';
import 'package:get/get.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<AppService>(AppService());
  }

}