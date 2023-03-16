import 'package:DLP/screens/auth/singin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(String status, String message, Color bgColor) {
  return Get.snackbar(status, message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: bgColor.withOpacity(0.1),
      colorText: bgColor);
}

appBar() {
  return AppBar(
    backgroundColor: Colors.blue,
    title: const Text("DLP"),
    actions: [
      GestureDetector(
          onTap: () {
            FirebaseAuth.instance.signOut();
            Get.to(() => LoginScreen());
          },
          child: const Icon(Icons.logout)),
      SizedBox(
        width: 20.0,
      )
    ],
  );
}
