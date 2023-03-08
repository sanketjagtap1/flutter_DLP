// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DLP/repository/user_repository/user_repository.dart';
import 'package:DLP/screens/admin/admin_dashboard.dart';
import 'package:DLP/screens/admin/admin_screen.dart';
import 'package:DLP/screens/auth/singin_screen.dart';
import 'package:DLP/utils/utils.dart';

final userRepo = Get.put(UserRepository());

sugnUpUser(user) async {
  User? userId = FirebaseAuth.instance.currentUser;

  await userRepo.createUser(user);
  Get.to(LoginScreen());
}

signInUser(String userName, String password, BuildContext context) async {
  try {
    final User? firebaseUser = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: userName, password: password))
        .user;

    if (firebaseUser != null) {
      print(firebaseUser);
      Get.to(() => AdminScreen());
    } else {}
  } on FirebaseAuthException catch (e) {
    showSnackBar(context, e.message!, Colors.red);
    print("Error $e");
  }
}
