import 'package:DLP/screens/constant/account_page.dart';
import 'package:DLP/screens/teacher/views/add_course.dart';
import 'package:DLP/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:DLP/screens/teacher/views/CoursesPage.dart';
import 'package:DLP/screens/teacher/views/DashboardPage.dart';
import 'package:DLP/screens/teacher/views/LecturesPage.dart';

class Teacher extends StatefulWidget {
  const Teacher({Key? key}) : super(key: key);

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    CoursesPage(),
    LecturesPage(),
    AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: appBar(),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.blue,
        selectedItemColor:
            isDarkMode ? Colors.white : Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: isDarkMode ? Colors.grey : Colors.black,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Lectures',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
