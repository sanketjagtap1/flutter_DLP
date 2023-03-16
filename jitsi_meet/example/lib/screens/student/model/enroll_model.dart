import 'package:cloud_firestore/cloud_firestore.dart';

class EnrollModel {
  final String? id;
  final String courseId;
  final String amount;
  final String email;
  final String paymentStatus;
  final String cardNo;
  final String studentId;
  final String createdDate;

  const EnrollModel({
    this.id,
    required this.courseId,
    required this.email,
    required this.amount,
    required this.paymentStatus,
    required this.cardNo,
    required this.studentId,
    required this.createdDate,
  });

  toJson() {
    return {
      "id": id,
      "CourseId": courseId,
      "Email": email,
      "Amount": amount,
      "PaymentStatus": paymentStatus,
      "CardNo": cardNo,
      "StudentId": studentId,
      "CreatedAt": createdDate,
    };
  }

  // get data
  factory EnrollModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return EnrollModel(
        id: document.id,
        courseId: data["CourseId"],
        email: data["Email"],
        amount: data["Amount"],
        paymentStatus: data["PaymentStatus"],
        cardNo: data["CardNo"],
        studentId: data["StudentId"],
        createdDate: data["CreatedAt"]);
  }
}
