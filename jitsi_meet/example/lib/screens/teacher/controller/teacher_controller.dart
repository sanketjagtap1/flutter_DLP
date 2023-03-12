import 'package:DLP/screens/teacher/model/course_model.dart';
import 'package:DLP/screens/teacher/repository/teacher_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TeacherController extends GetxController {
  static TeacherController get instance => Get.find();

  User? user = FirebaseAuth.instance.currentUser;
  final _userRepo = Get.put(TeacherRepository());

  // getCureses(userId) async {
  //   if (userId != null) {
  //     return await _userRepo.getCourses(userId);
  //   } else {
  //     Get.snackbar("Error", "Login To Continue");
  //   }
  // }

  Future<List<CourseModel>> getCureses(userId) async {
    return await _userRepo.getCourses(userId);
  }

  Future<List<CourseModel>> getAllCourses() async {
    return await _userRepo.getAllCourses();
  }

  // updateUser(UserModel user) async {
  //   await _userRepo.updateUser(user).then((value) {
  //     FirebaseAuth.instance.signOut();
  //     Get.to(LoginScreen());
  //   });
  // }
}
