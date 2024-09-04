import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChangeProfileController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController nameC;
  late TextEditingController statusC;
  late ImagePicker imagePicker;
  FirebaseStorage storage = FirebaseStorage.instance;

  XFile? pickImage = null;

  Future<String?> uploadImage(String id) async {
    Reference storageRef = storage.ref('$id.png');
    File file = File(pickImage!.path);

    try {
      await storageRef.putFile(file);
      final photoUrl = await storageRef.getDownloadURL();
      resetImage();
      return photoUrl;
    } catch (err) {
      print(err);
      return null;
    }
  }

  void resetImage() {
    pickImage = null;
    update();
  }

  void selectImage() async {
    try {
      final dataImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (dataImage != null) {
        pickImage = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickImage = null;
      update();
    }
  }

  @override
  void onInit() {
    emailC = TextEditingController(text: "ginanjar.bqs@gmail.com");
    nameC = TextEditingController(text: "ginanjar");
    statusC = TextEditingController(text: "");
    imagePicker = ImagePicker();

    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    nameC.dispose();
    statusC.dispose();

    super.onClose();
  }
}
