import 'package:DLP/screens/teacher/screens/add_course.dart';
import 'package:DLP/screens/teacher/screens/course_details.dart';
import 'package:flutter/material.dart';

class Course {
  final String name;
  final DateTime startDate;
  final String description;
  final double fees;
  final String duration;

  Course({
    required this.name,
    required this.startDate,
    required this.description,
    required this.fees,
    required this.duration,
  });
}

class CourseListPage extends StatefulWidget {
  const CourseListPage({Key? key}) : super(key: key);

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  List<Course> _courses = [
    Course(
      name: 'Flutter Course',
      startDate: DateTime.now(),
      description: 'Learn Flutter development',
      fees: 99.99,
      duration: '10 weeks',
    ),
    Course(
      name: 'React Course',
      startDate: DateTime.now(),
      description: 'Learn React development',
      fees: 149.99,
      duration: '12 weeks',
    ),
    Course(
      name: 'Angular Course',
      startDate: DateTime.now(),
      description: 'Learn Angular development',
      fees: 199.99,
      duration: '14 weeks',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course List'),
      ),
      body: ListView.builder(
        itemCount: _courses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_courses[index].name),
            subtitle: Text(_courses[index].startDate.toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CourseDetailPage(course: _courses[index]),
                ),
              );
            },
            trailing: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => AddCourseForm(course: _courses[index]),
                    builder: (context) => AddCourseForm(),
                  ),
                );
              },
              icon: Icon(Icons.edit),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCourseForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
