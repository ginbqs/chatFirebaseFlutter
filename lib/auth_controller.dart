import 'package:chat/core.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:chat/routes/name_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var user = UsersModel().obs;

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
        await _googleSignIn
            .signInSilently()
            .then((value) => _currentUser = value);

        final googleAuth = await _currentUser!.authentication;
        final credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        CollectionReference users = firestore.collection('users');

        users.doc(_currentUser!.email).update({
          "lastSignInTime":
              userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
        });

        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        user(UsersModel.fromJson(currUserData));
        user.refresh();

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

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        final box = GetStorage();
        box.write('skipIntro', true);

        CollectionReference users = firestore.collection('users');

        final checkUser = await users.doc(_currentUser!.email).get();

        if (checkUser.data() == null) {
          users.doc(_currentUser!.email).set({
            "uid": userCredential!.user!.uid,
            "name": _currentUser!.displayName,
            "email": _currentUser!.email,
            "photoUrl": _currentUser!.photoUrl ?? "noimage",
            "status": "",
            "createdAt":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "updatedAt": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updatedTime": DateTime.now().toIso8601String()
          });
        } else {
          users.doc(_currentUser!.email).update({
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });
        }

        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        user(UsersModel.fromJson(currUserData));
        user.refresh();

        isAuth.value = true;
        Get.offAllNamed(RouteName.DASHBOARD);
      } else {
        print("login google gagal");
        print(isSign);
      }
    } on FirebaseException catch (error) {
      print('error nin');
      print(error);
    }
  }

  Future<void> logout() async {
    // await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    Get.offAllNamed(RouteName.LOGIN);
  }
}
