// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:chat/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat/routes/name_route.dart';
import 'package:lottie/lottie.dart';
import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    controller.emailC.text = authC.user.value.email!;
    controller.nameC.text = authC.user.value.name!;
    controller.statusC.text = authC.user.value.status!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
          ),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
              Container(
                width: 120,
                height: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  'assets/logo/person.png',
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextField(
                controller: controller.emailC,
                cursorColor: Colors.purple,
                readOnly: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  label: Text('Email'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextField(
                controller: controller.nameC,
                cursorColor: Colors.purple,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  label: Text('Nama'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextField(
                controller: controller.statusC,
                cursorColor: Colors.purple,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  label: Text('Status'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('no image'),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Upload',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.purple),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {
                    authC.changeProfile(
                      controller.nameC.text,
                      controller.statusC.text,
                    );
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
