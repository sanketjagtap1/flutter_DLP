import 'package:DLP/screens/auth/check_user.dart';
import 'package:DLP/screens/teacher/screens/add_course.dart';
import 'package:DLP/screens/teacher/screens/course_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  var userRole = '';

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    // readData();
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
        home: CourseListPage());
  }
}


// user != null && userRole == 'admin'
//           ? AdminScreen()
//           : user != null && userRole == 'teacher'
//               ? TeacherDashboard()
//               : user != null && userRole == 'student'
//                   ? StudentDashboard()
//                   : LoginScreen(),