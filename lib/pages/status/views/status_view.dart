// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:chat/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat/routes/name_route.dart';
import 'package:lottie/lottie.dart';
import '../controllers/status_controller.dart';

class StatusView extends GetView<StatusController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    controller.statusC.text = authC.user.value.status!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Update Status',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: controller.statusC,
              cursorColor: Colors.purple,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: Get.width,
              child: ElevatedButton(
                onPressed: () {
                  authC.changeStatus(controller.statusC.text);
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
