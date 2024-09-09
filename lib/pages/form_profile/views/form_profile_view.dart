// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:chat/core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat/routes/name_route.dart';
import '../controllers/form_profile_controller.dart';

class FormProfileView extends GetView<FormProfileController> {
  final authC = Get.find<AuthController>();
  final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.purple,
  );
  final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: Column(
        children: [
          Material(
            elevation: 5,
            child: Container(
              margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Form Profile'),
                          Icon(
                            Icons.search,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Chats'),
                          Material(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(50),
                            child: InkWell(
                              onTap: () => Get.toNamed(RouteName.PROFILE),
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.person,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
