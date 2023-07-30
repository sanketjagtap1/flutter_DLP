import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:DLP/screens/student/model/enroll_model.dart';
import 'package:DLP/screens/teacher/model/course_model.dart';
import 'package:DLP/screens/teacher/model/lecture_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherRepository extends GetxController {
  static TeacherRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

// create Course Function
  createCourse(CourseModel course) async {
    await _db
        .collection("Courses")
        .add(course.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "New Course Has Been Created.",
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

  Future<List<CourseModel>> getCourses(String userId) async {
    final snapshot = await _db
        .collection("Courses")
        .where("UserID", isEqualTo: userId)
        .get();

    final userData =
        snapshot.docs.map((e) => CourseModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<List<CourseModel>> getAllCourses() async {
    final snapshot = await _db.collection("Courses").get();

    final userData =
        snapshot.docs.map((e) => CourseModel.fromSnapshot(e)).toList();
    return userData;
  }

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

  // add lecture
  addLecture(LectureModel lecture) async {
    await _db
        .collection("Lecture")
        .add(lecture.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "New Lecture Has Been Added.",
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

  Future<List<EnrollModel>> getEnrollStudentsByCourseIs(String courseId) async {
    final snapshot = await _db
        .collection("Enroll")
        .where("CourseId", isEqualTo: courseId)
        .get();

    final userData =
        snapshot.docs.map((e) => EnrollModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<List<EnrollModel>> getLectures(String courseId) async {
    final snapshot = await _db
        .collection("Lecture")
        .where("CourseId", isEqualTo: courseId)
        .get();

    final userData =
        snapshot.docs.map((e) => EnrollModel.fromSnapshot(e)).toList();
    return userData;
  }

  // getting data on the basis of ids
  // get lecture data
  Future<List<UserModel>> getUsers(List<dynamic> sudentIds) async {
    final snapshot =
        await _db.collection("Users").where("UserID", whereIn: sudentIds).get();

    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();

    return userData;
  }
}
