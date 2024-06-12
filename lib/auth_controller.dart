import 'package:chat/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:chat/routes/name_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  Future<void> firstInitialized() async {
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });

    await skipIntro().then((value) {
      if (value) {
        isSkipIntro.value = true;
      }
    });
  }

  Future<bool> skipIntro() async {
    final box = GetStorage();
    if (box.read('skipIntro') != null || box.read('skipIntro') == true) {
      return true;
    }
    return false;
  }

  Future<bool> autoLogin() async {
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  Future<void> login() async {
    try {
      await _googleSignIn.signIn().then((value) {
        _currentUser = value;
      });

      final isSign = await _googleSignIn.isSignedIn();
      if (isSign) {
        // print(_currentUser);
        final googleAuth = await _currentUser!.authentication;
        final credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        final box = GetStorage();
        box.write('skipIntro', true);

        isAuth.value = true;
        Get.offAllNamed(RouteName.DASHBOARD);
      } else {
        print("login google gagal");
        print(isSign);
      }
    } catch (error) {
      print('error nin');
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    Get.offAllNamed(RouteName.LOGIN);
  }
}
