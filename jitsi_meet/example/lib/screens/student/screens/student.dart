import 'package:DLP/screens/auth/singin_screen.dart';
import 'package:DLP/screens/constant/account_page.dart';
import 'package:DLP/screens/student/screens/ExplorePage.dart';
import 'package:DLP/screens/student/screens/LearningPage.dart';
import 'package:DLP/screens/teacher/LecturesPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ExplorePage(),
    LearningPage(),
    LecturesPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        title: const Text("DLP"),
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.to(() => LoginScreen());
              },
              child: const Icon(Icons.logout))
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Learning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.record_voice_over),
            label: 'Lectures',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
