import 'package:final_p/controllers/login_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 253, 255, 228),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 253, 255, 228),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(blurRadius: 20, offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: TextField(
                                controller: controller.emailCtrl,
                                decoration: const InputDecoration(
                                    hintText: "email",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: TextField(
                                controller: controller.passwordCtrl,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: "password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(children: [
                        MaterialButton(
                          onPressed: controller.login,
                          height: 40,
                          color: Colors.amberAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          onPressed: controller.back,
                          height: 40,
                          color: Colors.amberAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
