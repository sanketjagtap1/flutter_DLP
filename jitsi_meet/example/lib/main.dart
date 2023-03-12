import 'package:DLP/screens/auth/check_user.dart';
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
    // Get the brightness of the device's system theme
    // Set the theme mode to system by default

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DLP',
        theme: ThemeData(
            // Define your light theme here
            brightness: Brightness.light),
        darkTheme: ThemeData(brightness: Brightness.dark
            // Define your dark theme here
            ),
        themeMode: ThemeMode.system,
        home: CheckUser());
  }
}
