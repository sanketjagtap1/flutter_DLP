import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  // const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Dashboard Page'),
      ),
    );
  }
}
