import 'package:cloud_firestore/cloud_firestore.dart';

class LectureModel {
  final String? id;
  final String lectureTitle;
  final String courseId;
  final String teacherId;
  final String date;
  final String startTime;
  final String endTime;

  const LectureModel({
    this.id,
    required this.lectureTitle,
    required this.courseId,
    required this.teacherId,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  toJson() {
    return {
      "id": id,
      "lectureTitle": lectureTitle,
      "courseId": courseId,
      "teacherId": teacherId,
      "date": date,
      "startTime": startTime,
      "endTime": endTime,
    };
  }

  // get data
  factory LectureModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return LectureModel(
        id: document.id.toString(),
        lectureTitle: data["lectureTitle"].toString(),
        courseId: data["courseId"].toString(),
        teacherId: data["teacherId"].toString(),
        date: data["date"].toString(),
        startTime: data["startTime"].toString(),
        endTime: data["endTime"].toString());
  }
}
