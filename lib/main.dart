import 'package:chat/pages/utils/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
