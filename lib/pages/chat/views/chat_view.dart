// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:chat/routes/name_route.dart';
import 'package:lottie/lottie.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(100),
          child: Row(
            children: [
              SizedBox(width: 10),
              Icon(Icons.arrow_back),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.black38,
                child: Image.asset(
                  "assets/logo/person.png",
                  width: 30,
                ),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lorem Ipsum',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Obx(
              () => Text(
                'Statusnya ' + controller.isShowEmoji.value.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => PopScope(
          canPop: !controller.isShowEmoji.value,
          onPopInvoked: (_) {
            controller.isShowEmoji.value = false;
          },
          child: Column(
            children: [
              Text('Emoji ' + controller.isShowEmoji.value.toString()),
              Expanded(
                child: Container(
                  child: ListView(
                    children: [
                      ChatItem(
                        isSender: true,
                      ),
                      ChatItem(
                        isSender: false,
                      ),
                      ChatItem(
                        isSender: true,
                      ),
                      ChatItem(
                        isSender: false,
                      ),
                      ChatItem(
                        isSender: true,
                      ),
                      ChatItem(
                        isSender: false,
                      ),
                    ],
                  ),
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
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              onPressed: () {
                                // controller.isShowEmoji.toggle();
                                controller.changeIsEmoji();
                                print(controller.isShowEmoji);
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
                      onTap: () => {},
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
  const ChatItem({super.key, required this.isSender});
  final bool isSender;

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
              'Aku kamu Biasa terjadi Aku kamu Biasa terjadi Aku kamu Biasa terjadi Aku kamu Biasa terjadi Aku kamu Biasa terjadi',
              style: TextStyle(
                color: isSender ? Colors.white : Colors.purple,
              ),
            ),
          ),
          Text(
            '18:20 PM',
            style: TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
