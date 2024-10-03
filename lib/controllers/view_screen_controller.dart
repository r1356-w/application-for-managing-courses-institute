import 'package:dio/dio.dart';
import 'package:final_p/models/courses_details.dart';
import 'package:get/get.dart' hide Response;

class ViewScreenController extends GetxController {
  void onInit() async {
    await getData();
    super.onInit();
  }

  final List<Courses_details> courses_details = [];

  final RxBool _isLoaded = RxBool(false);

  bool get isLoaded => _isLoaded.value;

  Future<void> getData() async {
    Dio dio = Dio();
    Response r = await dio.get(
      "https://tech-center.cobyte01.com/api/home/open-courses",
    );
    if (r.data["success"]) {
      print(r.data);
      print(_isLoaded.value);
      List<dynamic> temp = r.data["data"];
      print(_isLoaded.value);
      courses_details.addAll(temp.map((e) => Courses_details.fromJson(e)));
      _isLoaded.value = true;
      print(_isLoaded.value);
    }
  }

  void goToThird() {
    Get.toNamed("/third");
  }
}
