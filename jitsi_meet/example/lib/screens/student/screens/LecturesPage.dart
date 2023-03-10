import 'package:flutter/material.dart';

class LecturesPage extends StatefulWidget {
  const LecturesPage({Key? key}) : super(key: key);

  @override
  State<LecturesPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LecturesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Lectures page"),
      ),
    );
  }
}
