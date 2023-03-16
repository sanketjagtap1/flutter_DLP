import 'package:DLP/screens/student/model/enroll_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentRepository extends GetxController {
  static StudentRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  enrollCourse(EnrollModel enroll) async {
    await _db
        .collection("Enroll")
        .add(enroll.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Successfully Enroll To Course",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        // ignore: body_might_complete_normally_catch_error
        .catchError((error, stackTrace) async {
      Get.snackbar("Failed", "Something went wrong. Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  // Future<UserModel> getUserDetails(String email) async {
  //   final snapshot =
  //       await _db.collection("Users").where("Email", isEqualTo: email).get();

  //   final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  //   return userData;
  // }

  // Future<List<UserModel>> getAllUsers() async {
  //   final snapshot = await _db.collection("Users").get();

  //   final userData =
  //       snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
  //   return userData;
  // }

  // Future<void> updateUser(UserModel user) async {
  //   print(user.toString());
  //   UserModel userData = UserModel(
  //       fullName: user.fullName,
  //       email: user.email,
  //       phoneNo: user.phoneNo,
  //       password: user.password,
  //       userId: user.userId,
  //       userType: "teacher");

  //   print(userData.userType);
  //   await _db
  //       .collection('Users')
  //       .doc(user.id)
  //       .update(userData.toJson())
  //       .whenComplete(
  //         () => Get.snackbar("Success", "Your Account Has Been Updated.",
  //             snackPosition: SnackPosition.TOP,
  //             backgroundColor: Colors.green.withOpacity(0.1),
  //             colorText: Colors.green),
  //       )
  //       .catchError((error, stackTrace) {
  //     Get.snackbar("Failed", "Something went wrong. Try Again",
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Colors.red.withOpacity(0.1),
  //         colorText: Colors.red);
  //     print(error.toString());
  //   });
  // }
}
