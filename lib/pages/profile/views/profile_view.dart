// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:chat/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat/routes/name_route.dart';
import 'package:lottie/lottie.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => authC.logout(),
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 175,
                  height: 175,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: authC.user.value.photoUrl == 'noimage'
                          ? Image.asset(
                              'assets/logo/person.png',
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              authC.user.value.photoUrl!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            )),
                ),
                Text(
                  authC.user.value.name!,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  authC.user.value.email!,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.edit_document),
                  title: Text(
                    'Update Status',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    size: 38,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.person),
                  title: Text(
                    'Change Profile',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    size: 38,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.color_lens),
                  title: Text(
                    'Change Theme',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    size: 38,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
