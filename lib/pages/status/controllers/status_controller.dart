import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  final count = 0.obs;
  late TextEditingController statusC;

  @override
  void onInit() {
    statusC = TextEditingController(text: "");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    statusC.dispose();
  }

  void increment() => count.value++;
}
