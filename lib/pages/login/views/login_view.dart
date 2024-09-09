// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:chat/core.dart';
import 'package:chat/theme/custom_color.dart';
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
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo/logo.png',
                          width: 120,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
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
                                color: Theme.of(context).colorScheme.primary,
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
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () => authC.login(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/google.png"),
                              SizedBox(width: 10),
                              Text(
                                'Sign in with Google',
                                style: TypographyBody.Regular.copyWith(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          style: OutlinedButton.styleFrom(
                            surfaceTintColor: CustomColor.primary[100],
                            side: BorderSide(color: CustomColor.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 1,
                )
              ],
            )),
      ),
    );
  }
}
