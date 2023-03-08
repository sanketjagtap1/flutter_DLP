import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DLP/screens/admin/admin_screen.dart';
import 'package:DLP/screens/auth/singin_screen.dart';
import 'package:DLP/screens/student/student_dashboard.dart';
import 'package:DLP/screens/teacher/Teacher_Dashboard.dart';
import 'package:DLP/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  String userRole = 'admin';

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    print(user?.uid.toString());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DLP',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: user != null && userRole == 'admin'
          ? AdminScreen()
          : user != null && userRole == 'teacher'
              ? TeacherDashboard()
              : user != null && userRole == 'student'
                  ? StudentDashboard()
                  : LoginScreen(),
    );
  }
}


// 