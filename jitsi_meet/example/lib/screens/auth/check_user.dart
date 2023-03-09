import 'package:DLP/screens/admin/controllers/profile_controller.dart';
import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:DLP/screens/admin/screens/admin_screen.dart';
import 'package:DLP/screens/student/student_dashboard.dart';
import 'package:DLP/screens/teacher/Teacher_Dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({Key? key}) : super(key: key);

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    print("object");
    final controller = Get.put(ProfileController());
    final user = FirebaseAuth.instance.currentUser;
    readData() async {
      UserModel data = await controller.getUserData();
      final userRole = data.userType;
      print(data.userType);
      if (user != null && userRole == 'admin') {
        Get.to(() => AdminScreen());
      }
      if (user != null && userRole == 'teacher') {
        Get.to(() => TeacherDashboard());
      }
      if (user != null && userRole == 'student') {
        Get.to(() => StudentDashboard());
      }
      // return data.userType; // This should print the fetched data to the console
    }

    readData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("DLP"),
      ),
    );
  }
}
