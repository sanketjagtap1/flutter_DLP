import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:DLP/screens/teacher/model/course_model.dart';
import 'package:DLP/screens/teacher/model/lecture_model.dart';
import 'package:DLP/screens/teacher/repository/teacher_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class TeacherController extends GetxController {
  static TeacherController get instance => Get.find();

  User? user = FirebaseAuth.instance.currentUser;
  final _userRepo = Get.put(TeacherRepository());

  Future<List<CourseModel>> getCureses(userId) async {
    return await _userRepo.getCourses(userId);
  }

  Future<void> updateCourse(CourseModel updatedUserData) async {
    print(updatedUserData);
    try {
      await FirebaseFirestore.instance
          .collection('Courses')
          .doc(updatedUserData.id)
          .update(updatedUserData.toJson());
    } catch (error) {
      Get.snackbar('Error', 'Failed to update user profile.');
      throw error;
    }
  }

  Future<List<CourseModel>> getAllCourses() async {
    return await _userRepo.getAllCourses();
  }

  // get student list from enroll table
  Future<List<UserModel>> getEnrollStudentList(id) async {
    var studentData = await _userRepo.getEnrollStudentsByCourseIs(id);

    // ittrating student id's from enroll course
    List<dynamic> users = [];
    for (var data in studentData) {
      print(data.studentId);
      users.add(data.studentId);
    }
    print(users);

    // getting data from table
    List<UserModel> userData = await _userRepo.getUsers(users);
    print(userData);
    return userData;
  }

  Future<void> sendMail(LectureModel data) async {
    await _userRepo.addLecture(data);

    var studentData =
        await _userRepo.getEnrollStudentsByCourseIs(data.courseId);

    final smtpServer = gmail('dlpapplication@gmail.com', 'dftpesfrtfwmjkxk');

    List<dynamic> recipients = [];

    for (var data in studentData) {
      print(data.email);
      recipients.add(data.email);
    }

    // Create our message.
    final message = Message()
      ..from = Address('dlpapplication@gmail.com', 'DLP')
      ..recipients.addAll(recipients)
      ..subject = 'Lecture Information'
      ..text = '''
    Dear Students,
    
    This email is to inform you that we will be having a lecture on ${data.lectureTitle}.
    
    Lecture will be start at ${data.date} from ${data.startTime} to ${data.endTime}.
    
    We hope to see you all there!
    
    Best regards,
    Your Professor
  ''';

    try {
      // Send the message.
      final sendReport = await send(message, smtpServer);

      // Print the result.
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
