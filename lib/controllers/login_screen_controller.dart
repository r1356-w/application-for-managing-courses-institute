import 'package:dio/dio.dart';
import 'package:final_p/services/app_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;

class LoginScreenController extends GetxController {
  LoginScreenController() {
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    service = Get.find();
  }

  late final TextEditingController emailCtrl;
  late final TextEditingController passwordCtrl;
  late final AppService service;

  Future<void> login() async {
    Dio dio = Dio();
    Response r = await dio.post(
      "https://tech-center.cobyte01.com/api/login",
      data: {
        "email": emailCtrl.text,
        "password": passwordCtrl.text,
      },
    );
    if (r.data["success"]) {
      service.token = r.data["data"]["token"];
      service.role = r.data["data"]["role"];
      if (service.role == "teacher") {
        Get.offNamed("/fifth");
      }

      if (service.role == "admin") {
        Get.offNamed("/fourth");
      }
    } else {
      Get.snackbar("Error", r.data["message"]);
    }
  }

  void back() {
    Get.toNamed("/second");
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
