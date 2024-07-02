import 'package:chat/pages/change_profile/bindings/change_profile_binding.dart';
import 'package:chat/pages/change_profile/views/change_profile_view.dart';
import 'package:chat/pages/chat/bindings/chat_binding.dart';
import 'package:chat/pages/chat/views/chat_view.dart';
import 'package:chat/pages/dashboard/views/dashboard_view.dart';
import 'package:chat/pages/friends/views/friend_view.dart';
import 'package:chat/pages/introduction/views/introduction_view.dart';
import 'package:chat/pages/login/views/login_view.dart';
import 'package:chat/pages/profile/views/profile_view.dart';
import 'package:chat/pages/status/bindings/status_binding.dart';
import 'package:chat/pages/status/views/status_view.dart';
import 'package:chat/routes/name_route.dart';
import 'package:get/get.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.LOGIN,
      page: () => LoginView(),
    ),
    GetPage(
      name: RouteName.INTRODUCTION,
      page: () => IntroductionView(),
    ),
    GetPage(
      name: RouteName.DASHBOARD,
      page: () => DashboardView(),
    ),
    GetPage(
      name: RouteName.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: RouteName.PROFILE,
      page: () => ProfileView(),
    ),
    GetPage(
      name: RouteName.FRIEND,
      page: () => FriendView(),
    ),
    GetPage(
      name: RouteName.STATUS,
      page: () => StatusView(),
      binding: ChangeStatusBinding(),
    ),
    GetPage(
        name: RouteName.CHANGE_PROFILE,
        page: () => ChangeProfileView(),
        binding: ChangeProfileBinding()),
  ];
}
