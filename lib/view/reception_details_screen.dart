import 'package:final_p/controllers/admin_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ReceptionScreen extends GetView<AdminScreenController> {
  const ReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.all(5),
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
              child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Obx(
                    () => controller.isLoaded
                        ? GridView.count(crossAxisCount: 1, children: [
                            ...controller.receptions.map(
                              (e) => Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 253, 255, 228),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(1, 3),
                                            blurRadius: 15),
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        e.name.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        e.email.toString(),
                                      ),
                                      Text(e.phone.toString()),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                controller
                                                    .onTapEditReception(e);
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                controller
                                                    .deleteReception(e.id!);
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ])
                        : const Center(child: CircularProgressIndicator()),
                  ))),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: controller.onTapAddReception,
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
