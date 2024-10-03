import 'package:final_p/controllers/view_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ViewScreen extends GetView<ViewScreenController> {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    "View Courses",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: TextButton(
                      onPressed: controller.goToThird,
                      child: const Icon(
                        Icons.login,
                        color: Color.fromARGB(255, 5, 5, 5),
                        size: 30,
                      )),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 253, 255, 228),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Obx(
                        () => controller.isLoaded
                            ? GridView.count(crossAxisCount: 1, children: [
                                ...controller.courses_details.map(
                                  (e) => Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 253, 255, 228),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(1, 3),
                                                blurRadius: 15),
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            e.courseName ?? "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                          Text(
                                            "Cost : ${e.cost.toString()}",
                                          ),
                                          Text("Level : ${e.level.toString()}"),
                                          // Text(
                                          //     "Teacher : ${e.teacherName ?? ""}"),
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: 6,
                                )
                              ])
                            : const Center(child: CircularProgressIndicator()),
                      ))))
        ],
      ),
    );
  }
}
