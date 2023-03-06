// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_example/screens/auth/home_screen.dart';
import 'package:jitsi_meet_example/screens/auth/singin_screen.dart';
import 'package:jitsi_meet_example/utils/utils.dart';

sugnUpUser(
    String userName, String email, String mobile, String password) async {
  User? userId = FirebaseAuth.instance.currentUser;

  try {
    await FirebaseFirestore.instance.collection("users").doc().set({
      'userName': userName,
      'email': email,
      'mobile': mobile,
      'password': password,
      'createdAt': DateTime.now(),
      'userId': userId!.uid
    }).then((value) =>
        {FirebaseAuth.instance.signOut(), Get.to(() => LoginScreen())});
  } on FirebaseAuthException catch (e) {
    print("Error $e");
  }
}

signInUser(String userName, String password, BuildContext context) async {
  try {
    final User? firebaseUser = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: userName, password: password))
        .user;

    if (firebaseUser != null) {
      print(firebaseUser);
      Get.to(() => HomeScreen());
    } else {}
  } on FirebaseAuthException catch (e) {
    showSnackBar(context, e.message!, Colors.red);
    print("Error $e");
  }
}
