import 'package:final_p/controllers/welcome_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends GetView<WelcomeScreenController> {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 253, 255, 228),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(right: 200),
                decoration: const BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(150))),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Image.asset("assets/images/logo.PNG"),
              ),
            ),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: controller.goToSecond,
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.yellowAccent,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(150)),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ));
  }
}
