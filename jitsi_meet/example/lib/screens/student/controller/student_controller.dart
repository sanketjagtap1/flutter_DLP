import 'package:DLP/screens/student/repository/student_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StudentController extends GetxController {
  static StudentController get instance => Get.find();

  User? user = FirebaseAuth.instance.currentUser;
  final _studentRepo = Get.put(StudentRepository());

  enrollCourse(data) async {
    return await _studentRepo.enrollCourse(data);
  }

  // getUserData(email) async {
  //   if (email != null) {
  //     return await _userRepo.getUserDetails(email);
  //   } else {
  //     Get.snackbar("Error", "Login To Continue");
  //   }
  // }

  // Future<List<UserModel>> getAllUsers() async {
  //   return await _userRepo.getAllUsers();
  // }

  // updateUser(UserModel user) async {
  //   await _userRepo.updateUser(user).then((value) {
  //     FirebaseAuth.instance.signOut();
  //     Get.to(LoginScreen());
  //   });
  // }
}
