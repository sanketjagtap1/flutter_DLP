import 'package:DLP/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DLP/screens/constant/account_page.dart';
import 'package:DLP/screens/admin/screens/admin_dashboard.dart';
import 'package:DLP/screens/constant/courses_page.dart';
import 'package:DLP/screens/auth/singin_screen.dart';
import 'package:DLP/screens/admin/screens/users_page.dart';
import 'package:DLP/screens/admin/screens/student_user.dart';

class AdminScreen extends StatefulWidget {
  // const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  User? user;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // AdminDashboard(),
    UsersPage(),
    studentPage(),
    CoursesPage(),
    AccountPage(),
  ];

  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    print(user.toString());
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: appBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.blue,
        selectedItemColor: isDarkMode ? Colors.white : Colors.blue,
        unselectedItemColor: isDarkMode ? Colors.grey : Colors.black,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Teacher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
