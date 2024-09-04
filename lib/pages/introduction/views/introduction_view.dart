// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:chat/auth_controller.dart';
import 'package:chat/pages/utils/helper_widget.dart';
import 'package:chat/theme/constant_color.dart';
import 'package:chat/theme/typography_body.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat/pages/introduction/controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Welcome",
            bodyWidget: Text(
              "Want to meet new friends who share your hobbies and interests? Hobbies app is here to connect you with people who share your passions, so you can enjoy your favorite activities together.",
              style: TypographyBody.Regular,
              textAlign: TextAlign.center,
            ),
            image: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Center(
                child: Image.asset(
                  'assets/images/intro1.png',
                ),
              ),
            ),
          ),
          PageViewModel(
            title: "Find True Friends",
            bodyWidget: Text(
              "With advanced search features, Hobbies App makes it easy to find like-minded friends. Fill out your profile with your interests and hobbies, and we'll match you with other users who share your interests.",
              style: TypographyBody.Regular,
              textAlign: TextAlign.center,
            ),
            image: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Center(
                child: Image.asset(
                  'assets/images/intro2.png',
                ),
              ),
            ),
          ),
          PageViewModel(
            title: "Start Your Adventure",
            bodyWidget: Text(
              "Start your social adventure on Hobbies App today! Easily sign up, create an attractive profile, and find new friends who are ready to share the fun. Ready to expand your social circle? Click the 'Sign Up' button and get started now!",
              style: TypographyBody.Regular,
              textAlign: TextAlign.center,
            ),
            image: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Center(
                child: Image.asset(
                  'assets/images/intro3.png',
                ),
              ),
            ),
          ),
        ],
        showSkipButton: true,
        skip: const Text("Skip", style: TextStyle(color: Colors.black26)),
        next: const Text("Next", style: TextStyle(color: Colors.blue)),
        done: const Text("Done",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800)),
        onDone: () => authC.toLogin(),
        onSkip: () => authC.toLogin(),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Colors.blue,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
