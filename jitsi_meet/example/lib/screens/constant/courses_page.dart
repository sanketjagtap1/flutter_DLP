import 'package:DLP/screens/admin/controllers/profile_controller.dart';
import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:DLP/screens/teacher/controller/teacher_controller.dart';
import 'package:DLP/screens/teacher/model/course_model.dart';
import 'package:DLP/screens/teacher/views/add_course.dart';
import 'package:DLP/screens/teacher/views/add_lecture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  // Create a reference for the selected course
  CourseModel? selectedCourse;
  // Create a reference to the controller
  final controller = Get.put(TeacherController());
  final userController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userData = userController.getUserData(user!.email);

    print(userData);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<CourseModel>>(
          future: controller.getAllCourses(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 4.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12.0),
                              ),
                              child: Image.network(
                                snapshot.data![index].imgUrl.toString(),
                                height: 120.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].courseName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    snapshot.data![index].desc,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Add view button to display the course details in a popup

                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedCourse = snapshot.data![index];
                                });
                                _showCourseDetailsDialog(context);
                              },
                              child: Text('View Details'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return Center(child: Text("Something went wrong!"));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Function to show the course details popup dialog
  void _showCourseDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        // Call the method to get all courses here
        // Make sure to replace 'YourControllerClass' with the actual class name of the controller
        Future<List<UserModel>> usersFuture =
            controller.getEnrollStudentList(selectedCourse?.id);

        return AlertDialog(
          title: Text(
            "Course Name: ${selectedCourse?.courseName?.toUpperCase() ?? ""}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: FutureBuilder<List<UserModel>>(
            future: usersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Future is still loading
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Future completed with an error
                return Text("Error: ${snapshot.error}");
              } else {
                // Future completed successfully, display user details
                List<UserModel>? users = snapshot.data;

                // Sort the users list based on the fullName in ascending order
                users?.sort((a, b) => a.fullName.compareTo(b.fullName));

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Enroll Student List (${users?.length ?? 0} Users)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Display user details in a DataTable
                      if (users != null && users.isNotEmpty)
                        DataTable(
                          columns: [
                            DataColumn(
                              label: Center(
                                  child: Text("Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                            ),
                          ],
                          rows: users
                              .map((user) => DataRow(
                                    cells: [
                                      DataCell(Text(user.fullName)),
                                    ],
                                  ))
                              .toList(),
                        ),
                    ],
                  ),
                );
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
