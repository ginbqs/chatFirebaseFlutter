// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:chat/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:chat/routes/name_route.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  final authC = Get.find<AuthController>();
  final String chat_id = (Get.arguments as Map<String, dynamic>)['chat_id'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Get.back(),
          borderRadius: BorderRadius.circular(100),
          child: Row(
            children: [
              SizedBox(width: 10),
              Icon(Icons.arrow_back),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.black38,
                child: StreamBuilder<DocumentSnapshot<Object?>>(
                  stream: controller.streamFriendData(
                      (Get.arguments as Map<String, dynamic>)['friendEmail']),
                  builder: (context, snapshotFriend) {
                    if (snapshotFriend.connectionState ==
                        ConnectionState.active) {
                      var dataFriend =
                          snapshotFriend.data!.data() as Map<String, dynamic>;
                      if (dataFriend['photoUrl'] != 'noimage') {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(dataFriend['photoUrl'],
                              fit: BoxFit.cover),
                        );
                      } else {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset("assets/logo/person.png",
                              width: 30, fit: BoxFit.cover),
                        );
                      }
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset("assets/logo/person.png",
                          width: 30, fit: BoxFit.cover),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        title: StreamBuilder<DocumentSnapshot<Object?>>(
          stream: controller.streamFriendData(
              (Get.arguments as Map<String, dynamic>)['friendEmail']),
          builder: (context, snapshotFriend) {
            if (snapshotFriend.connectionState == ConnectionState.active) {
              var dataFriend =
                  snapshotFriend.data!.data() as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${dataFriend['name']}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    dataFriend['status'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Loading ...',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Loading ...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
        centerTitle: false,
      ),
      body: Obx(
        () => PopScope(
          canPop: !controller.isShowEmoji.value,
          onPopInvoked: (_) {
            controller.isShowEmoji.value = false;
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.streamChats(chat_id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          var allData = snapshot.data!.docs;
                          Timer(
                            Duration.zero,
                            () => controller.scrollC.jumpTo(
                                controller.scrollC.position.maxScrollExtent),
                          );
                          return ListView.builder(
                              controller: controller.scrollC,
                              itemCount: allData.length,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${allData[index]['groupTime']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ChatItem(
                                        msg: '${allData[index]['msg']}',
                                        isSender: allData[index]['pengirim'] ==
                                                authC.user.value.email!
                                            ? true
                                            : false,
                                        time: allData[index]['time'],
                                      ),
                                    ],
                                  );
                                } else {
                                  if (allData[index]['groupTime'] ==
                                      allData[index - 1]['groupTime']) {
                                    return ChatItem(
                                      msg: '${allData[index]['msg']}',
                                      isSender: allData[index]['pengirim'] ==
                                              authC.user.value.email!
                                          ? true
                                          : false,
                                      time: allData[index]['time'],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        Text(
                                          '${allData[index]['groupTime']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ChatItem(
                                          msg: '${allData[index]['msg']}',
                                          isSender: allData[index]
                                                      ['pengirim'] ==
                                                  authC.user.value.email!
                                              ? true
                                              : false,
                                          time: allData[index]['time'],
                                        ),
                                      ],
                                    );
                                  }
                                }
                              });
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: controller.isShowEmoji.isTrue
                      ? 5
                      : context.mediaQueryPadding.bottom,
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: Get.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: controller.chatC,
                          focusNode: controller.focusNode,
                          autocorrect: false,
                          onEditingComplete: () => controller.newChat(
                            authC.user.value.email!,
                            Get.arguments as Map<String, dynamic>,
                            controller.chatC.text,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              onPressed: () {
                                controller.changeIsEmoji();
                                controller.focusNode.unfocus();
                              },
                              icon: Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.purple,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => controller.newChat(
                        authC.user.value.email!,
                        Get.arguments as Map<String, dynamic>,
                        controller.chatC.text,
                      ),
                      borderRadius: BorderRadius.circular(100),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.purple,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Offstage(
                offstage: !controller.isShowEmoji.value,
                child: EmojiPicker(
                  onEmojiSelected: (Category? category, Emoji emoji) {
                    controller.addEmoji(emoji);
                  },
                  // textEditingController:
                  //     textEditingController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                  config: Config(
                    height: controller.isShowEmoji.value ? 195 : 100,
                    checkPlatformCompatibility: true,
                    emojiViewConfig: EmojiViewConfig(
                      emojiSizeMax: 28 * 1.2,
                    ),
                    swapCategoryAndBottomBar: false,
                    skinToneConfig: const SkinToneConfig(
                      indicatorColor: Colors.purple,
                    ),
                    categoryViewConfig: const CategoryViewConfig(
                      indicatorColor: Colors.purple,
                      iconColorSelected: Colors.purple,
                      showBackspaceButton: false,
                      backspaceColor: Colors.purple,
                    ),
                    bottomActionBarConfig: const BottomActionBarConfig(
                      showBackspaceButton: false,
                      showSearchViewButton: false,
                    ),
                    searchViewConfig: const SearchViewConfig(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.isSender, this.msg, this.time});
  final bool isSender;
  final String? msg;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(
        top: 15,
        bottom: 0,
        left: isSender ? 80 : 20,
        right: isSender ? 20 : 80,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isSender ? Colors.purple : Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isSender ? 10 : 0),
                bottomRight: Radius.circular(isSender ? 0 : 10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              border: Border.all(color: Colors.purple, width: 1.5),
            ),
            child: Text(
              '${msg}',
              style: TextStyle(
                color: isSender ? Colors.white : Colors.purple,
              ),
            ),
          ),
          Text(
            '${DateFormat.jm().format(DateTime.parse(time!))}',
            style: TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
