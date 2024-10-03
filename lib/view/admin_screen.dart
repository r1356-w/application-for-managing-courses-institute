import 'package:final_p/controllers/admin_screen_controller.dart';
import 'package:final_p/view/accountant_details_screen.dart';
import 'package:final_p/view/courses_details_screen.dart';
import 'package:final_p/view/open_course_screen.dart';
import 'package:final_p/view/teacher_screen.dart';
import 'package:final_p/view/reception_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class AdminScreen extends GetView<AdminScreenController> {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amberAccent,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    "Welcome Admin",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: TextButton(
                      onPressed: controller.logout,
                      child: const Icon(
                        Icons.logout,
                        color: Color.fromARGB(255, 5, 5, 5),
                        size: 25,
                      )),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 253, 255, 228),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: const DefaultTabController(
                    length: 5,
                    child: Scaffold(
                      backgroundColor: Colors.amberAccent,
                      appBar: TabBar(
                          labelColor: Color.fromARGB(255, 0, 0, 0),
                          tabs: [
                            Tab(
                              text: "Courses",
                            ),
                            Tab(
                              text: "Open Course",
                            ),
                            Tab(
                              text: "teacher",
                            ),
                            Tab(
                              text: "Receptions",
                            ),
                            Tab(
                              text: "Accountants",
                            ),
                          ]),
                      body: TabBarView(children: [
                        CoursesDetailscreen(),
                        OpenCoureScreen(),
                        TeachersScreen(),
                        ReceptionScreen(),
                        AccountantScreen(),
                      ]),
                    ),
                  ))),
        ]));
  }
}
