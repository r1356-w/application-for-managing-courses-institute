import 'package:dio/dio.dart';
import 'package:final_p/models/courses_details.dart';
import 'package:final_p/models/user.dart';
import 'package:final_p/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';

class AdminScreenController extends GetxController {
  get dropdownCallback => null;

  @override
  void onInit() async {
    service = Get.find();
    await _getCourses();
    await getTeacher();
    getOpenCourses();
    super.onInit();
    title = TextEditingController();

    description = TextEditingController();

    level = TextEditingController();

    hours = TextEditingController();

    courseId = TextEditingController();

    finishData = TextEditingController();

    cost = TextEditingController();

    title = TextEditingController();

    phone = TextEditingController();

    name = TextEditingController();

    email = TextEditingController();

    role = TextEditingController();

    role = TextEditingController();
  }

  late final AppService service;

  final List<Courses_details> courses_details = [];

  final List<Courses_details> open_course = [];

  final List<User> user = [];

  final List<User> teachers = [];

  final List<User> receptions = [];

  final List<User> accountants = [];

  final RxBool _isLoaded = RxBool(false);

  bool get isLoaded => _isLoaded.value;

  late TextEditingController title;

  late final TextEditingController description;

  late final TextEditingController level;

  late final TextEditingController hours;

  late final TextEditingController cost;

  late final TextEditingController finishData;

  late final TextEditingController courseId;

  late final TextEditingController name;

  late final TextEditingController phone;

  late final TextEditingController email;

  late TextEditingController role;

  late Rx<User> t = Rx(teachers[0]);

  late final DateTime selectedDate;

// courses Tap
  Future<void> _getCourses() async {
    _isLoaded.value = false;
    courses_details.clear();
    Dio dio = Dio();
    Response r =
        await dio.get("https://tech-center.cobyte01.com/api/admin/view-course",
            options: Options(headers: {
              "Authorization": "Bearer ${service.token}",
            }));
    if (r.data["success"]) {
      List<dynamic> temp = r.data["data"];
      courses_details
          .addAll(temp.map((e) => Courses_details.fromJsonAsCourse(e)));
      _isLoaded.value = true;
    } else {
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  Future<void> logout() async {
    Dio dio = Dio();
    Response r = await dio.post(
      "https://tech-center.cobyte01.com/api/logout",
      options: Options(
        headers: {
          "Authorization": "Bearer ${service.token}",
        },
      ),
    );
    if (r.data["success"]) {
      service.token = null;
      service.role = null;
      Get.offAllNamed("/third");
    } else {
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  Future<void> _editCourses(int id) async {
    Dio dio = Dio();
    Response r = await dio.put(
        "https://tech-center.cobyte01.com/api/admin/edit-course/$id",
        data: {
          "title": title.text,
          "description": description.text,
          "level": level.text,
          "hours": hours.text,
        },
        options: Options(headers: {
          "Authorization": "Bearer ${service.token}",
        }));
    if (r.data["success"]) {
      await _getCourses();
    } else {
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  void onTapEdit(Courses_details c) {
    title.text = c.courseName ?? "";
    description.text = c.description ?? "";
    level.text = c.level.toString();
    hours.text = c.hours.toString();
    Get.defaultDialog(
        backgroundColor: const Color.fromARGB(255, 253, 255, 228),
        title: "edit course",
        content: Column(children: [
          TextField(
            controller: title,
            decoration: const InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: description,
            decoration: const InputDecoration(
                hintText: "description",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: level,
            decoration: const InputDecoration(
                hintText: "level",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: hours,
            decoration: const InputDecoration(
                hintText: "hours",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                _editCourses(c.id!);
                courses_details.clear();
              },
              child: const Text(
                "Save",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]));
  }

  Future<void> deleteCourses(int id) async {
    Dio dio = Dio();
    Response r = await dio.delete(
        "https://tech-center.cobyte01.com/api/admin/delete-course/$id",
        options: Options(headers: {
          "Authorization": "Bearer ${service.token}",
        }));
    if (r.data["success"]) {
      await _getCourses();
    } else {
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  Future<void> addCourse() async {
    _isLoaded.value = false;
    courses_details.clear();
    Dio dio = Dio();
    Response r = await dio.post(
      "https://tech-center.cobyte01.com/api/admin/add-course",
      options: Options(headers: {
        "Authorization": "Bearer ${service.token}",
      }),
      data: {
        "title": title.text,
        "description": description.text,
        "hours": int.parse(hours.text),
        "level": int.parse(level.text)
      },
    );
    if (r.data["success"]) {
      Get.close(1);
      await _getCourses();
    } else {
      Get.close(1);
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  void onTapAdd() {
    Get.defaultDialog(
        backgroundColor: const Color.fromARGB(255, 253, 255, 228),
        title: "Add course",
        textConfirm: "Save",
        confirmTextColor: Colors.white,
        buttonColor: Colors.black,
        onConfirm: addCourse,
        content: Column(children: [
          TextField(
            controller: title,
            decoration: const InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: description,
            decoration: const InputDecoration(
                hintText: "description",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: level,
            decoration: const InputDecoration(
                hintText: "level",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: hours,
            decoration: const InputDecoration(
                hintText: "hours",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ]));
  }

  Future<void> endCourses(int id) async {
    _isLoaded.value = false;
    open_course.clear();
    Dio dio = Dio();
    Response r = await dio.post(
        "https://tech-center.cobyte01.com/api/admin/end-course/$id",
        options: Options(headers: {
          "Authorization": "Bearer ${service.token}",
        }));
    if (r.data["success"]) {
      await getOpenCourses();
    } else {
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

//open course Tap
  Future<void> getOpenCourses() async {
    _isLoaded.value = false;
    open_course.clear();
    Dio dio = Dio();
    Response r = await dio.get(
      "https://tech-center.cobyte01.com/api/home/open-courses",
    );
    print("---------------------------------------- \n ${r.data} hjsjsjaajk");
    if (r.data["success"]) {
      List<dynamic> temp = r.data["data"];
      open_course.addAll(temp.map((e) => Courses_details.fromJson(e)));
      _isLoaded.value = true;
    }
  }

  Future<void> onOpenDetails(int id, BuildContext context) async {
    Get.defaultDialog(
      backgroundColor: const Color.fromARGB(255, 253, 255, 228),
      title: "Open Course",
      textConfirm: "Save",
      confirmTextColor: Colors.white,
      buttonColor: Colors.black,
      onConfirm: () async {
        Dio dio = Dio();
        Response r = await dio.post(
            "https://tech-center.cobyte01.com/api/admin/add-open-course",
            data: {
              "courseId": id,
              "teacherId": t.value.id,
              "startDate": DateFormat("yyyy-MM-dd").format(selectedDate),
              "cost": cost.text,
            },
            options:
                Options(headers: {"Authorization": "Bearer ${service.token}"}));
        if (r.data["success"]) {
          Get.close(1);
          await getOpenCourses();
        }
      },
      content: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Obx(
          () => DropdownButton<User>(
            value: t.value,
            items: teachers.map((User value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value.name ?? ""),
              );
            }).toList(),
            onChanged: (i) {
              t.value = i!;
            },
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text(
              "StartDate",
            ),
            onPressed: () async {
              final DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                selectedDate =
                    DateTime(date.year, date.month, date.day, date.hour);
              }
            }),
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: TextField(
                controller: cost,
                decoration: const InputDecoration(
                    hintText: "Cost",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
            Expanded(child: Container()),
          ],
        )
      ]),
    );
  }

// view users
  Future<void> getTeacher() async {
    _isLoaded.value = false;
    teachers.clear();
    Dio dio = Dio();
    Response r =
        await dio.get("https://tech-center.cobyte01.com/api/admin/view-user",
            options: Options(headers: {
              "Authorization": "Bearer ${service.token}",
            }));
    if (r.data["success"]) {
      Map<String, dynamic> temp = r.data["data"];

      List<dynamic> accountant = temp["accountant"];
      accountants.addAll(accountant.map((e) => User.fromJson(e)));

      List<dynamic> teacher = temp["teacher"];
      teachers.addAll(teacher.map((e) => User.fromJson(e)));

      List<dynamic> reception = temp["reception"];
      receptions.addAll(reception.map((e) => User.fromJson(e)));

      _isLoaded.value = true;
      print(_isLoaded.value);
    } else {
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  Future<void> _editTeacher(int id) async {
    _isLoaded.value = false;
    teachers.clear();
    user.clear();
    Dio dio = Dio();
    Response r = await dio.put(
        "https://tech-center.cobyte01.com/api/admin/edit-user/$id",
        data: {
          "name": name.text,
          "phone": phone.text,
        },
        options: Options(headers: {
          "Authorization": "Bearer ${service.token}",
        }));
    if (r.data["success"]) {
      await getTeacher();
      print(user);
      _isLoaded.value = true;
      Get.close(1);
    } else {
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  void onTapEditTeacher(User c) {
    name.text = c.name ?? "";
    phone.text = c.phone ?? "";
    Get.defaultDialog(
        backgroundColor: const Color.fromARGB(255, 253, 255, 228),
        title: "edit User",
        content: Column(children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: phone,
            decoration: const InputDecoration(
                hintText: "Phone",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                _editTeacher(c.id!);
              },
              child: const Text(
                "Save",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]));
  }

  Future<void> deleteTeacher(int id) async {
    Dio dio = Dio();
    Response r = await dio.delete(
        "https://tech-center.cobyte01.com/api/admin/delete-user/$id",
        options: Options(headers: {
          "Authorization": "Bearer ${service.token}",
        }));
    if (r.data["success"]) {
      await getTeacher();
      print(user);
    } else {
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  Future<void> addTeacher() async {
    _isLoaded.value = false;
    teachers.clear();
    Dio dio = Dio();
    Response r = await dio.post(
      "https://tech-center.cobyte01.com/api/admin/add-user",
      options: Options(headers: {
        "Authorization": "Bearer ${service.token}",
      }),
      data: {
        "name": name.text,
        "phone": phone.text,
        "email": email.text,
        "role": role.text,
      },
    );
    if (r.data["success"]) {
      Get.close(1);
      await getTeacher();
    } else {
      Get.close(1);
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  void onTapAddTeacher() {
    Get.defaultDialog(
        backgroundColor: const Color.fromARGB(255, 253, 255, 228),
        title: "Add Teacher",
        textConfirm: "Save",
        confirmTextColor: Colors.white,
        buttonColor: Colors.black,
        onConfirm: addTeacher,
        content: Column(children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(
                hintText: "name",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: phone,
            decoration: const InputDecoration(
                hintText: "phone",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: email,
            decoration: const InputDecoration(
                hintText: "email",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: role,
            decoration: const InputDecoration(
                hintText: "role",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ]));
  }

  Future<void> _editAccountant(int id) async {
    _isLoaded.value = false;
    accountants.clear();
    user.clear();
    Dio dio = Dio();
    Response r = await dio.put(
        "https://tech-center.cobyte01.com/api/admin/edit-user/$id",
        data: {
          "name": name.text,
          "phone": phone.text,
        },
        options: Options(headers: {
          "Authorization": "Bearer ${service.token}",
        }));
    if (r.data["success"]) {
      await getTeacher();
      print(user);
      _isLoaded.value = true;
      Get.close(1);
    } else {
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  void onTapEditAccountant(User c) {
    name.text = c.name ?? "";
    phone.text = c.phone ?? "";
    Get.defaultDialog(
        backgroundColor: const Color.fromARGB(255, 253, 255, 228),
        title: "edit Accountant",
        content: Column(children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: phone,
            decoration: const InputDecoration(
                hintText: "Phone",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                _editAccountant(c.id!);
              },
              child: const Text(
                "Save",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]));
  }

  Future<void> deleteAccountant(int id) async {
    _isLoaded.value = false;
    accountants.clear();
    Dio dio = Dio();
    Response r = await dio.delete(
        "https://tech-center.cobyte01.com/api/admin/delete-user/$id",
        options: Options(headers: {
          "Authorization": "Bearer ${service.token}",
        }));
    if (r.data["success"]) {
      await getTeacher();
      print(user);
    } else {
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  Future<void> addAccountant() async {
    _isLoaded.value = false;
    accountants.clear();
    Dio dio = Dio();
    Response r = await dio.post(
      "https://tech-center.cobyte01.com/api/admin/add-user",
      options: Options(headers: {
        "Authorization": "Bearer ${service.token}",
      }),
      data: {
        "name": name.text,
        "phone": phone.text,
        "email": email.text,
        "role": role.text,
      },
    );
    if (r.data["success"]) {
      Get.close(1);
      await getTeacher();
    } else {
      Get.close(1);
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  void onTapAddAccountant() {
    Get.defaultDialog(
        backgroundColor: const Color.fromARGB(255, 253, 255, 228),
        title: "Add Accountant",
        textConfirm: "Save",
        confirmTextColor: Colors.white,
        buttonColor: Colors.black,
        onConfirm: addAccountant,
        content: Column(children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(
                hintText: "name",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: phone,
            decoration: const InputDecoration(
                hintText: "phone",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: email,
            decoration: const InputDecoration(
                hintText: "email",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: role,
            decoration: const InputDecoration(
                hintText: "role",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ]));
  }

  Future<void> _editReception(int id) async {
    _isLoaded.value = false;
    receptions.clear();
    user.clear();
    Dio dio = Dio();
    Response r = await dio.put(
        "https://tech-center.cobyte01.com/api/admin/edit-user/$id",
        data: {
          "name": name.text,
          "phone": phone.text,
        },
        options: Options(headers: {
          "Authorization": "Bearer ${service.token}",
        }));
    if (r.data["success"]) {
      await getTeacher();
      print(user);
      _isLoaded.value = true;
      Get.close(1);
    } else {
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  void onTapEditReception(User c) {
    name.text = c.name ?? "";
    phone.text = c.phone ?? "";
    Get.defaultDialog(
        backgroundColor: const Color.fromARGB(255, 253, 255, 228),
        title: "edit Reception",
        content: Column(children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: phone,
            decoration: const InputDecoration(
                hintText: "Phone",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                _editReception(c.id!);
              },
              child: const Text(
                "Save",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]));
  }

  Future<void> deleteReception(int id) async {
    _isLoaded.value = false;
    receptions.clear();
    Dio dio = Dio();
    Response r = await dio.delete(
        "https://tech-center.cobyte01.com/api/admin/delete-user/$id",
        options: Options(headers: {
          "Authorization": "Bearer ${service.token}",
        }));
    if (r.data["success"]) {
      await getTeacher();
      print(user);
    } else {
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  Future<void> addReception() async {
    _isLoaded.value = false;
    receptions.clear();
    Dio dio = Dio();
    Response r = await dio.post(
      "https://tech-center.cobyte01.com/api/admin/add-user",
      options: Options(headers: {
        "Authorization": "Bearer ${service.token}",
      }),
      data: {
        "name": name.text,
        "phone": phone.text,
        "email": email.text,
        "role": role.text,
      },
    );
    if (r.data["success"]) {
      Get.close(1);
      await getTeacher();
    } else {
      Get.close(1);
      Get.snackbar(
        "Error",
        r.data["message"],
      );
    }
  }

  void onTapAddReception() {
    Get.defaultDialog(
        backgroundColor: const Color.fromARGB(255, 253, 255, 228),
        title: "Add Reception",
        textConfirm: "Save",
        confirmTextColor: Colors.white,
        buttonColor: Colors.black,
        onConfirm: addReception,
        content: Column(children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(
                hintText: "name",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: phone,
            decoration: const InputDecoration(
                hintText: "phone",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: email,
            decoration: const InputDecoration(
                hintText: "email",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
          TextField(
            controller: role,
            decoration: const InputDecoration(
                hintText: "role",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ]));
  }
}
