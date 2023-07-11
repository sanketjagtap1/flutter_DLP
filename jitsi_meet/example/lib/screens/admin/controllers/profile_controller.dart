import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:DLP/screens/auth/singin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:DLP/repository/user_repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  User? user = FirebaseAuth.instance.currentUser;
  final _userRepo = Get.put(UserRepository());

  getUserData(email) async {
    if (email != null) {
      return await _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login To Continue");
    }
  }

  Future<void> updateUser(UserModel updatedUserData) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(updatedUserData.id)
          .update(updatedUserData.toJson());
    } catch (error) {
      Get.snackbar('Error', 'Failed to update user profile.');
      throw error;
    }
  }

  deleteUser(userId) async {
    print('Deleting user with ID: $userId');
    await _userRepo.deleteUser(userId);
  }

  Future<List<UserModel>> getAllUsers() async {
    return await _userRepo.getAllUsers();
  }

  Future<List<UserModel>> getAllTeacherUsers() async {
    return await _userRepo.getAllTeacherUsers();
  }
}
