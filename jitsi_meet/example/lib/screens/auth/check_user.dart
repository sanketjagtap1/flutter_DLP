import 'package:DLP/screens/admin/controllers/profile_controller.dart';
import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:DLP/screens/admin/screens/admin_screen.dart';
import 'package:DLP/screens/auth/singin_screen.dart';
import 'package:DLP/screens/student/screens/student.dart';
import 'package:DLP/screens/teacher/views/teacher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
      if (user != null) {
        final user = FirebaseAuth.instance.currentUser;
        UserModel data = await controller.getUserData(user!.email);
        final userRole = data.userType;
        print(data.userType);
        if (userRole == 'admin') {
          Get.to(() => AdminScreen());
        } else if (userRole == 'teacher') {
          Get.to(() => Teacher());
        } else if (userRole == 'student') {
          Get.to(() => Student());
        }
      } else {
        Get.to(() => LoginScreen());
      }

      // return data.userType; // This should print the fetched data to the console
    }

    Future.delayed(Duration(seconds: 5), () {
      readData();
      // code to run after 5 seconds
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Lottie.asset(
          'assets/splash.json',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
