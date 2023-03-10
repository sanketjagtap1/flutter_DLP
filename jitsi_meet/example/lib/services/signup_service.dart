import 'package:DLP/repository/user_repository/user_repository.dart';
import 'package:DLP/screens/admin/controllers/profile_controller.dart';
import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:DLP/screens/admin/screens/admin_screen.dart';
import 'package:DLP/screens/auth/singin_screen.dart';
import 'package:DLP/screens/student/screens/student.dart';
import 'package:DLP/screens/teacher/teacher.dart';
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
  );

  await userRepo.createUser(user);
  Get.to(LoginScreen());
}

signInUser(String userName, String password, BuildContext context) async {
  try {
    final User? firebaseUser = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: userName, password: password))
        .user;

    final controller = Get.put(ProfileController());
    final user = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      UserModel data = await controller.getUserData();
      final userRole = data.userType;
      print(data.userType);

      if (user != null && userRole == 'admin') {
        Get.to(() => AdminScreen());
      } else if (user != null && userRole == 'teacher') {
        Get.to(() => Teacher());
      } else if (user != null && userRole == 'student') {
        Get.to(() => Student());
      }
    } else {}
  } on FirebaseAuthException catch (e) {
    showSnackBar(context, e.message!, Colors.red);
    print("Error $e");
  }
}
