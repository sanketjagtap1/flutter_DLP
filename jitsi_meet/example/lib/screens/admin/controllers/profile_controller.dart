import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:DLP/repository/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  User? user = FirebaseAuth.instance.currentUser;
  final _userRepo = Get.put(UserRepository());

  getUserData() async {
    final email = user!.email;

    if (email != null) {
      return await _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login To Continue");
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    return await _userRepo.getAllUsers();
  }
}
