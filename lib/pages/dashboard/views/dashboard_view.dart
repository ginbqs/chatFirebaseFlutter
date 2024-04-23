// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat/routes/name_route.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  final List<Widget> myChats = List.generate(
    20,
    (index) => ListTile(
      onTap: () => Get.toNamed(RouteName.CHAT),
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
        'chat orang ke ${index + 1}',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black54,
        ),
      ),
      trailing: CircleAvatar(
        child: Text('3'),
        radius: 15,
        backgroundColor: Colors.black12,
      ),
    ),
  ).reversed.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Text('Mengobrol'),
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
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: myChats.length,
              itemBuilder: (context, index) => myChats[index],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteName.FRIEND),
        child: Icon(
          Icons.message_rounded,
          size: 30,
          color: Colors.white,
        ),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
