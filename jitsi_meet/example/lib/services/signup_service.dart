// ignore_for_file: avoid_print

import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DLP/repository/user_repository/user_repository.dart';
import 'package:DLP/screens/admin/screens/admin_screen.dart';
import 'package:DLP/screens/auth/singin_screen.dart';
import 'package:DLP/utils/utils.dart';

final userRepo = Get.put(UserRepository());

sugnUpUser(fullname, email, phone, password) async {
  User? userId = FirebaseAuth.instance.currentUser;

  final user = UserModel(
    fullName: fullname,
    email: email,
    phoneNo: phone,
    password: password,
    userId: userId!.uid,
    userType: 'student',
  );

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
