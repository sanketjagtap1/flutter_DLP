import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DLP/screens/constant/account_page.dart';
import 'package:DLP/screens/admin/screens/admin_dashboard.dart';
import 'package:DLP/screens/constant/courses_page.dart';
import 'package:DLP/screens/admin/screens/users_page.dart';
import 'package:DLP/screens/auth/singin_screen.dart';

class AdminScreen extends StatefulWidget {
  // const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  User? user;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AdminDashboard(),
    UsersPage(),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Users',
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
