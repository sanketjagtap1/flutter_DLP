import 'package:DLP/screens/student/model/enroll_model.dart';
import 'package:DLP/screens/student/repository/student_repository.dart';
import 'package:DLP/screens/teacher/model/lecture_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StudentController extends GetxController {
  static StudentController get instance => Get.find();

  User? user = FirebaseAuth.instance.currentUser;
  final _studentRepo = Get.put(StudentRepository());

  enrollCourse(data) async {
    return await _studentRepo.enrollCourse(data);
  }

  Future<List<LectureModel>> getTeacherLectures() async {
    List<LectureModel> lectureData =
        await _studentRepo.getTeacherLectures(user!.uid);

    return lectureData;
  }

  Future<List<LectureModel>> getLectures() async {
    List<String> enrollData = await getAllLectures();

    print(enrollData);

    List<LectureModel> lectureData = await _studentRepo.getLectures(enrollData);

    for (int i = 0; i < lectureData.length; i++) {
      print(lectureData[i].lectureTitle);

      await Future.delayed(Duration(seconds: 1));
    }

    return lectureData;
  }

  Future<List<String>> getAllLectures() async {
    List<EnrollModel> data = await _studentRepo.getAllLectures(user!.uid);
    List<String> courseIds = [];
    for (var data in data) {
      print(data.courseId);
      courseIds.add(data.courseId);
    }
    return courseIds;
  }

  // updateUser(UserModel user) async {
  //   await _userRepo.updateUser(user).then((value) {
  //     FirebaseAuth.instance.signOut();
  //     Get.to(LoginScreen());
  //   });
  // }
}
