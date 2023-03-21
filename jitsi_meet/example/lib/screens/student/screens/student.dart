import 'package:DLP/screens/constant/account_page.dart';
import 'package:DLP/screens/student/screens/ExplorePage.dart';
import 'package:DLP/screens/student/screens/LecturesPage.dart';
import 'package:DLP/utils/utils.dart';
import 'package:flutter/material.dart';

class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ExplorePage(),
    LecturesPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: appBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.blue,
        selectedItemColor:
            isDarkMode ? Colors.white : Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: isDarkMode ? Colors.grey : Colors.black,
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
