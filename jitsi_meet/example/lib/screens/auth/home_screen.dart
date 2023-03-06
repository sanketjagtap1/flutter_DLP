import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_example/screens/auth/singin_screen.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DLP Home"),
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.to(() => LoginScreen());
              },
              child: const Icon(Icons.logout))
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  // Get.to(() => AddTeacherScreen());
                },
                child: Text("Add Teacher")),
          )
        ],
      )),
    );
  }
}
