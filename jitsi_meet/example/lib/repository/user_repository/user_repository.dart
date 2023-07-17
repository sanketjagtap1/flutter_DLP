import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:DLP/screens/admin/screens/student_user.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your Account Has Been Created.",
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

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();

    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  deleteUser(String id) async {
    final userRef = FirebaseFirestore.instance.collection('Users').doc(id);
    await userRef.delete().whenComplete(() {
      Get.snackbar(
        "Success",
        "User Has Been Deleted.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.5),
        colorText: Colors.green,
      ); // Replace '/student-page' with the actual route of your student page
    });
  }

  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _db
        .collection("Users")
        .where("userType", isEqualTo: "student")
        .get();

    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<List<UserModel>> getAllTeacherUsers() async {
    final snapshot = await _db
        .collection("Users")
        .where("userType", isEqualTo: "teacher")
        .get();

    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUser(UserModel user) async {
    print(user.toString());
    UserModel userData = UserModel(
        fullName: user.fullName,
        email: user.email,
        phoneNo: user.phoneNo,
        password: user.password,
        userId: user.userId,
        status: 'Pending',
        userType: user.userType);

    print(userData.userType);
    await _db
        .collection('Users')
        .doc(user.id)
        .update(userData.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your Account Has Been Updated.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Failed", "Something went wrong. Try Again",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }
}
