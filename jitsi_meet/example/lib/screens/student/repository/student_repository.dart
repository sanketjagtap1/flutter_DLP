import 'package:DLP/screens/student/model/enroll_model.dart';
import 'package:DLP/screens/teacher/model/course_model.dart';
import 'package:DLP/screens/teacher/model/lecture_model.dart';
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

// get lecture data
  Future<List<EnrollModel>> getAllLectures(userId) async {
    final snapshot = await _db
        .collection("Enroll")
        .where("StudentId", isEqualTo: userId)
        .get();

    final userData =
        snapshot.docs.map((e) => EnrollModel.fromSnapshot(e)).toList();

    return userData;
  }

  // get lecture data
  Future<List<LectureModel>> getTeacherLectures(userId) async {
    final snapshot = await _db
        .collection("Lecture")
        .where("teacherId", isEqualTo: userId)
        .get();

    final userData =
        snapshot.docs.map((e) => LectureModel.fromSnapshot(e)).toList();

    return userData;
  }

  // get lecture data
  Future<List<LectureModel>> getLectures(List<String> courseIds) async {
    final snapshot = await _db
        .collection("Lecture")
        .where("courseId", whereIn: courseIds)
        .get();

    final userData =
        snapshot.docs.map((e) => LectureModel.fromSnapshot(e)).toList();

    return userData;
  }
}
