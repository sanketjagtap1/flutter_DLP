import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  final String? id;
  final String courseName;
  final String desc;
  final String starDate;
  final int duration;
  final int fees;
  final String userId;
  final String imgUrl;

  const CourseModel({
    this.id,
    required this.courseName,
    required this.desc,
    required this.starDate,
    required this.duration,
    required this.fees,
    required this.userId,
    required this.imgUrl,
  });

  toJson() {
    return {
      "CourseName": courseName,
      "Description": desc,
      "StartDate": starDate,
      "Duration": duration,
      "Fees": fees,
      "UserID": userId,
      "Image": imgUrl,
    };
  }

  // get data
  factory CourseModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CourseModel(
        id: document.id,
        courseName: data["CourseName"],
        desc: data["Description"],
        starDate: data["StartDate"],
        duration: data["Duration"],
        fees: data["Fees"],
        userId: data["UserID"],
        imgUrl: data["Image"]);
  }
}
