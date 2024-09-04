import 'package:chat/theme/constant_theme.dart';
import 'package:chat/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat/auth_controller.dart';
import 'package:chat/pages/utils/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCkf--qevlVtCTOBhXqoKor0BUUZvtRUi0",
          authDomain: "chatapp-ginbqs.firebaseapp.com",
          projectId: "chatapp-ginbqs",
          storageBucket: "chatapp-ginbqs.appspot.com",
          messagingSenderId: "268401291870",
          appId: "1:268401291870:web:90e48f7cd63a6ae14b7acf"),
    );
  } else {
    await Firebase.initializeApp();
  }
  await GetStorage.init();
  runApp(MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
    );
    //   return FutureBuilder(
    //       future: authC.firstInitialized(),
    //       builder: (context, snapshot) => const SplashScreen());
  }
}
