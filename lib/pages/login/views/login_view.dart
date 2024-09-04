// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:chat/core.dart';
import 'package:chat/theme/typography_body.dart';
import 'package:chat/theme/typography_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: Colors.blue,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/logo/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'HOBBIES',
                          style: TypographyLogo.SemiBold.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TypographyBody.SemiBold.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Hobbies App",
                          style: TypographyBody.SemiBold.copyWith(
                            color: Colors.blue,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          "Find nearby friends with the same hobbies! Join and enjoy fun activities together.",
                          style: TypographyBody.Regular.copyWith(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: ElevatedButton(
                            onPressed: () => authC.login(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.g_mobiledata_rounded,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Sign With Google',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  flex: 2,
                )
              ],
            )),
      ),
    );
  }
}
