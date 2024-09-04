// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:chat/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat/routes/name_route.dart';
import 'package:lottie/lottie.dart';
import '../controllers/friend_controller.dart';

class FriendView extends GetView<FriendController> {
  final authC = Get.find<AuthController>();
  // final List<Widget> myFriends = List.generate(
  //   20,
  //   (index) =>
  // ).reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(135),
        child: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Cari Teman"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          flexibleSpace: Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextField(
                onChanged: (value) =>
                    controller.searchFriend(value, authC.user.value.email!),
                cursorColor: Colors.purple,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  hintText: "Cari Teman",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  suffixIcon: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.tempSearch.length < 1
            ? Center(
                child: Container(
                  width: Get.width * 0.7,
                  height: Get.width * 0.7,
                  decoration: BoxDecoration(color: Colors.purple),
                  child: Center(
                      child: Text(
                    'Kosong',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.tempSearch.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black26,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child:
                          controller.tempSearch[index]['photoUrl'] == 'noimage'
                              ? Image.asset('assets/logo/person.png',
                                  fit: BoxFit.cover)
                              : Image.network(
                                  controller.tempSearch[index]['photoUrl'],
                                  fit: BoxFit.cover),
                    ),
                  ),
                  title: Text(
                    '${controller.tempSearch[index]['name']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: Text(
                    '${controller.tempSearch[index]['email']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () => authC.addNewConnection(
                      controller.tempSearch[index]['email'],
                    ),
                    child: Chip(
                      label: Text('Message'),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
