import 'package:get/get.dart';

import '../controllers/form_photo_controller.dart';

class FormPhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormPhotoController>(
      () => FormPhotoController(),
    );
  }
}
