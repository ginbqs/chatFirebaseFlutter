// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:chat/core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat/routes/name_route.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
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
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.chatsStream(authC.user.value.email!),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.active) {
                  var allChat = snapshot1.data!.docs;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: allChat.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<
                          DocumentSnapshot<Map<String, dynamic>>>(
                        stream: controller
                            .friendStream(allChat[index]['connection']!),
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState ==
                              ConnectionState.active) {
                            var data = snapshot2.data!.data();
                            return data!['status'] == ''
                                ? ListTile(
                                    onTap: () => controller.goToChatRoom(
                                        allChat[index].id,
                                        authC.user.value.email!,
                                        allChat[index]['connection']),
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black26,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: data['photoUrl'] == 'noimage'
                                            ? Image.asset(
                                                'assets/logo/person.png',
                                                fit: BoxFit.cover)
                                            : Image.network(
                                                "${data['photoUrl']}",
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                    title: Text(
                                      '${data!['name']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    trailing:
                                        allChat[index]['total_unread'] == 0
                                            ? SizedBox()
                                            : CircleAvatar(
                                                child: Text(
                                                    '${allChat[index]['total_unread']}'),
                                                radius: 15,
                                                backgroundColor: Colors.black12,
                                              ),
                                  )
                                : ListTile(
                                    onTap: () => controller.goToChatRoom(
                                        allChat[index].id as String,
                                        authC.user.value.email!,
                                        allChat[index]['connection'] as String),
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black26,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: data['photoUrl'] == 'noimage'
                                            ? Image.asset(
                                                'assets/logo/person.png',
                                                fit: BoxFit.cover)
                                            : Image.network(
                                                "${data['photoUrl']}",
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                    title: Text(
                                      '${data!['name']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${data['status']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    trailing:
                                        allChat[index]['total_unread'] == 0
                                            ? SizedBox()
                                            : CircleAvatar(
                                                child: Text(
                                                    '${allChat[index]['total_unread']}'),
                                                radius: 15,
                                                backgroundColor: Colors.black12,
                                              ),
                                  );
                          }
                          return Text('');
                        },
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => Get.toNamed(RouteName.FRIEND),
        onPressed: () => Get.changeTheme(Get.isDarkMode ? light : dark),
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
