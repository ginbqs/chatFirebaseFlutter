// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat/routes/name_route.dart';
import 'package:lottie/lottie.dart';
import '../controllers/friend_controller.dart';

class FriendView extends GetView<FriendController> {
  final List<Widget> myFriends = List.generate(
    20,
    (index) => ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black26,
      ),
      title: Text(
        'Orang ke ${index + 1}',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(
        'email@gmail.com',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black54,
        ),
      ),
      trailing: GestureDetector(
        onTap: () => Get.toNamed(RouteName.CHAT),
        child: Chip(
          label: Text('Message'),
        ),
      ),
    ),
  ).reversed.toList();

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
      body: myFriends.length < 1
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
              itemCount: myFriends.length,
              itemBuilder: (context, index) => myFriends[index],
            ),
    );
  }
}
