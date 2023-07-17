import 'package:DLP/repository/user_repository/user_repository.dart';
import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:DLP/screens/admin/screens/admin_screen.dart';
import 'package:DLP/screens/auth/singin_screen.dart';
import 'package:DLP/screens/student/screens/student.dart';
import 'package:DLP/screens/teacher/views/teacher.dart';
import 'package:DLP/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    status: 'Approved',
  );

  await userRepo.createUser(user);
  Get.to(LoginScreen());
}

signInUser(String userName, String password, BuildContext context) async {
  try {
    final User? firebaseUser = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: userName, password: password))
        .user;

    Future.delayed(Duration(seconds: 1), () async {
      if (firebaseUser != null) {
        print(firebaseUser.email);
        final UserModel userDetails =
            await userRepo.getUserDetails(firebaseUser.email.toString());

        print(userDetails.userType);

        if (userDetails.userType == 'admin') {
          Get.to(() => AdminScreen());
        } else if (userDetails.userType == 'student') {
          Get.to(() => Student());
        } else if (userDetails.userType == 'teacher') {
          Get.to(() => Teacher());
        }
      }
      // code to run after 5 seconds
    });
  } on FirebaseAuthException catch (e) {
    showSnackBar('error', e.message!, Colors.red);
    print("Error $e");
  }
}
