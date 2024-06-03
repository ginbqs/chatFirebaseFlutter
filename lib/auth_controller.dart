import 'package:chat/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:chat/routes/name_route.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

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
    _googleSignIn.signOut();
    Get.offAllNamed(RouteName.LOGIN);
  }
}
