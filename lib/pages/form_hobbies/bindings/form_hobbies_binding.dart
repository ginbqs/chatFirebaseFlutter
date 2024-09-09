import 'package:get/get.dart';

import '../controllers/form_hobbies_controller.dart';

class FormHobbiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormHobbiesController>(
      () => FormHobbiesController(),
    );
  }
}
