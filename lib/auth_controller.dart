import 'package:chat/core.dart';
import 'package:get/get.dart';
import 'package:chat/routes/name_route.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  void login() {
    Get.offAllNamed(RouteName.DASHBOARD);
  }
}
