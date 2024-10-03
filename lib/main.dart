import 'package:final_p/bindings/initial_bindings.dart';
import 'package:final_p/bindings/login_screen_bindings.dart';
import 'package:final_p/bindings/view_screen_bindings.dart';
import 'package:final_p/bindings/welcome_screen_bindings.dart';
import 'package:final_p/view/admin_screen.dart';
import 'package:final_p/view/login_screen.dart';
import 'package:final_p/view/view_courses.dart';
import 'package:final_p/view/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/admin_screen_bindings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),
      getPages: [
        GetPage(
          name: "/",
          page: () => const WelcomeScreen(),
          binding: WelcomeScreenBindings(),
        ),
        GetPage(
          name: "/second",
          page: () => const ViewScreen(),
          binding: ViewScreenBindings(),
        ),
        GetPage(
          name: "/third",
          page: () => const LoginScreen(),
          binding: LoginScreenBindings(),
        ),
        GetPage(
            name: "/fourth",
            page: () => const AdminScreen(),
            binding: AdminScreenBindings()),
      ],
    );
  }
}
