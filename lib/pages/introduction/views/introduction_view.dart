// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat/pages/introduction/controllers/introduction_controller.dart';
import 'package:chat/routes/name_route.dart';
import 'package:lottie/lottie.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Selamat Datang",
            body:
                "Langkah pertama, buatlah profil Anda! Tambahkan foto dan sedikit informasi tentang diri Anda untuk memberikan sentuhan personal.",
            image: const Center(
              child: Icon(Icons.waving_hand, size: 50.0),
            ),
          ),
          PageViewModel(
            title: "Teman",
            body:
                "Langkah berikutnya, temukan teman-teman Anda! Mulailah dengan mencari dan menambahkan kontak yang Anda kenal.",
            image: const Center(
              child: Icon(Icons.waving_hand, size: 50.0),
            ),
          ),
          PageViewModel(
            title: "Chat",
            body:
                "Sekarang saatnya untuk mengobrol! Kirim pesan teks, kirim gambar, atau kirim stiker lucu kepada teman-teman Anda.",
            image: Container(
              width: Get.width * 0.6,
              child: Center(
                  child: Lottie.asset('assets/lottie/splash_screen.json')),
            ),
          ),
        ],
        showSkipButton: true,
        skip: const Text("Skip"),
        next: const Text("Next"),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w700)),
        onDone: () => Get.offAllNamed(RouteName.LOGIN),
        onSkip: () => Get.offAllNamed(RouteName.LOGIN),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).colorScheme.secondary,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
