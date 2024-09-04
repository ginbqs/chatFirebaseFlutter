// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:chat/auth_controller.dart';
import 'package:chat/theme/constant_color.dart';
import 'package:chat/theme/typography_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../home/home.dart';

class SplashScreen extends StatefulWidget {
  final authC = Get.put(AuthController(), permanent: true);
  SplashScreen({Key? key, authC}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    first().then((value) => seconds());
  }

  Future<void> first() async {
    await widget.authC.firstInitialized();
  }

  Future<void> seconds() async {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const Home(),
      ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/logo.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 10),
            Text(
              'HOBBIES',
              style: TypographyLogo.SemiBold.copyWith(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
