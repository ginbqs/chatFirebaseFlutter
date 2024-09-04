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

  Future<void> toLogin() async {
    isSkipIntro.value = true;
    return Get.offAllNamed(RouteName.LOGIN);
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

        await users.doc(_currentUser!.email).update({
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
          await users.doc(_currentUser!.email).set({
            "uid": userCredential!.user!.uid,
            "name": _currentUser!.displayName,
            "keyName": _currentUser!.displayName!.substring(0, 1).toUpperCase(),
            "email": _currentUser!.email,
            "photoUrl": _currentUser!.photoUrl ?? "noimage",
            "status": "",
            "createdAt":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "updatedAt": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updatedTime": DateTime.now().toIso8601String(),
            "chats": [],
          });
        } else {
          await users.doc(_currentUser!.email).update({
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

  void changeProfile(String name, String status) {
    CollectionReference users = firestore.collection('users');
    final date = DateTime.now().toIso8601String();
    final data = {
      'name': name,
      "keyName": name.substring(0, 1).toUpperCase(),
      'status': status,
      'lastSignInTime':
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      'updatedTime': date,
    };

    users.doc(_currentUser!.email).update(data);

    user.update((user) {
      user!.name = name;
      user!.keyName = name.substring(0, 1).toUpperCase();
      user!.status = status;
      user.lastSignInTime =
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updatedTime = date;
    });
    user.refresh();

    Get.defaultDialog(title: "Success", middleText: "change profile success");
  }

  void changeStatus(String status) {
    CollectionReference users = firestore.collection('users');
    final date = DateTime.now().toIso8601String();

    users.doc(_currentUser!.email).update({
      'status': status,
      'lastSignInTime':
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      'updatedTime': date,
    });

    user.update((user) {
      user!.status = status;
      user.lastSignInTime =
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updatedTime = date;
    });
    user.refresh();

    Get.defaultDialog(title: "Success", middleText: "status success");
  }

  void addNewConnection(String friendEmail) async {
    CollectionReference users = firestore.collection('users');
    CollectionReference chats = firestore.collection('chats');
    String date = DateTime.now().toIso8601String();
    bool flatNewConnection = false;
    var chat_id;
    print('addNewConnection ${friendEmail}');

    final docChats =
        await users.doc(_currentUser!.email).collection('chats').get();
    List<dynamic> check = docChats.docs.map((doc) => doc.data()).toList();
    print('${check}');
    print('docChats ${docChats.docs.length}');
    // final docChats = (docUser.data() as Map<String, dynamic>)['chats'] as List;

    if (docChats.docs.length != 0) {
      print(
          'users => ${_currentUser!.email} sudah pernah chat dengan siapapun');
      final checkConnetion = await users
          .doc(_currentUser!.email)
          .collection('chats')
          .where('connection', isEqualTo: friendEmail)
          .get();

      if (checkConnetion.docs.length != 0) {
        print(
            'users => ${_currentUser!.email} sudah pernah chat dengan ${friendEmail}');
        flatNewConnection = false;
        chat_id = checkConnetion.docs[0].id;
      } else {
        flatNewConnection = true;
      }
    } else {
      flatNewConnection = true;
    }

    if (flatNewConnection) {
      print(
          'users => ${_currentUser!.email} tidak pernah chat dengan ${friendEmail}');
      final chatsDoc = await chats.where("connections", whereIn: [
        {
          _currentUser!.email,
          friendEmail,
        },
        {
          friendEmail,
          _currentUser!.email,
        }
      ]).get();

      if (chatsDoc.docs.length != 0) {
        print('chats => ${_currentUser!.email} pernah chat ${friendEmail}');
        final chatDataId = await chatsDoc.docs[0].id;
        final chatsData = await chatsDoc.docs[0].data() as Map<String, dynamic>;
        print("chatsData ${chatsData}");

        await users
            .doc(_currentUser!.email)
            .collection('chats')
            .doc(chatDataId)
            .set({
          "connection": friendEmail,
          "lastTime": chatsData['lastTime'],
          "total_unread": 0,
        });

        final listChats =
            await users.doc(_currentUser!.email).collection('chats').get();
        if (listChats.docs.length != 0) {
          List<ChatUser> dataListChats = List<ChatUser>.empty();
          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats = dataListChats.toList();
            dataListChats.add(ChatUser(
              chat_id: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat['lastTime'],
              total_unread: dataDocChat['total_unread'],
            ));
          });
          user.update((user) {
            user!.chats = dataListChats;
          });
        } else {
          user.update((user) {
            user!.chats = [];
          });
        }
        chat_id = chatDataId;
        user.refresh();
      } else {
        print(
            'chats => ${_currentUser!.email} tidak pernah chat ${friendEmail}');
        final newChatDoc = await chats.add({
          "connections": [
            _currentUser!.email,
            friendEmail,
          ],
        });

        await chats.doc(newChatDoc.id).collection('chat');

        await users
            .doc(_currentUser!.email)
            .collection('chats')
            .doc(newChatDoc.id)
            .set({
          "connection": friendEmail,
          "lastTime": date,
          "total_unread": 0,
        });

        final listChats =
            await users.doc(_currentUser!.email).collection('chats').get();
        print('listChats');
        print(listChats);

        if (listChats.docs.length != 0) {
          List<ChatUser> dataListChats = List<ChatUser>.empty();
          print('dataListChats');
          print(dataListChats);
          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            print('dataDocdataDocChatChat');
            print(dataDocChat);

            var dataDocChatId = element.id;
            print(dataDocChatId);
            dataListChats = dataListChats.toList();
            dataListChats.add(ChatUser(
              chat_id: dataDocChatId,
              connection: dataDocChat['connection'],
              lastTime: dataDocChat['lastTime'],
              total_unread: dataDocChat['total_unread'],
            ));
          });
          print(dataListChats);
          print('====');
          user.update((user) {
            user!.chats = dataListChats;
          });
        } else {
          print('haa');
          user.update((user) {
            user!.chats = [];
          });
        }
        chat_id = newChatDoc.id;
        user.refresh();
      }
    }
    print(chat_id);

    Get.toNamed(
      RouteName.CHAT,
      arguments: {
        "chat_id": chat_id as String,
        "friendEmail": friendEmail as String,
      },
    );
  }

  void updatePhotoUrl(String url) {
    CollectionReference users = firestore.collection('users');
    final date = DateTime.now().toIso8601String();

    users.doc(_currentUser!.email).update({
      'photoUrl': url,
      'lastSignInTime':
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      'updatedTime': date,
    });

    user.update((user) {
      user!.photoUrl = url;
      user.lastSignInTime =
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updatedTime = date;
    });
    user.refresh();

    Get.defaultDialog(title: "Success", middleText: "Photo success");
  }
}
