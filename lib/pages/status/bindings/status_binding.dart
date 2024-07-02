import 'package:get/get.dart';

import '../controllers/status_controller.dart';

class ChangeStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatusController>(
      () => StatusController(),
    );
  }
}
