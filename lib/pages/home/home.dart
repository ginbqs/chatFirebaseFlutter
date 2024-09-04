// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:chat/auth_controller.dart';
import 'package:chat/routes/name_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/page_route.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          title: 'Chat App',
          initialRoute: auth.isSkipIntro.isTrue
              ? (auth.isAuth.isTrue ? RouteName.DASHBOARD : RouteName.LOGIN)
              : RouteName.INTRODUCTION,
          // initialRoute: RouteName.LOGIN,
          // initialRoute:
          //     auth.isSkipIntro.isTrue ? RouteName.INITIAL : RouteName.INITIAL,
          getPages: AppPage.pages,
        ));
  }
}
