import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendController extends GetxController {
  final count = 0.obs;
  late TextEditingController searchC;

  var queryAwal = [].obs;
  var tempSearch = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void searchFriend(String data, String email) async {
    if (data.length == 0) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      var capitalized = data.substring(0, 1).toUpperCase() + data.substring(1);

      if (queryAwal.length == 0 && data.length == 1) {
        CollectionReference users = await firestore.collection('users');

        final keyNameResult = await users
            .where('keyName', isEqualTo: data.substring(0, 1).toUpperCase())
            .where('email', isNotEqualTo: email)
            .get();
        if (keyNameResult.docs.length > 0) {
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            queryAwal.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
        } else {
          print("data tidak ditemukan");
        }

        if (queryAwal.length != 0) {
          tempSearch.value = [];
          queryAwal.forEach((element) {
            if (element['name'].startsWith(capitalized)) {
              tempSearch.add(element);
            }
          });
        }
      }
    }
    queryAwal.refresh();
    tempSearch.refresh();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
