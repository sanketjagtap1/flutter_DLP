import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:DLP/repository/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  User? user = FirebaseAuth.instance.currentUser;
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = user!.email;

    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login To Continue");
    }
  }
}
