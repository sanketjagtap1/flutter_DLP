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
  CourseModel? selectedCourse;
  final controller = Get.put(TeacherController());
  final user = FirebaseAuth.instance.currentUser;

  // Function to show the course update popup dialog
  void _showUpdateCourseDialog(BuildContext context, CourseModel course) {
    TextEditingController courseNameController =
        TextEditingController(text: course.courseName);
    TextEditingController courseDescController =
        TextEditingController(text: course.desc);
    TextEditingController courseFeesController =
        TextEditingController(text: course.fees.toString());

    TextEditingController courseDurationController =
        TextEditingController(text: course.duration.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Course"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Course Name:"),
              TextFormField(
                controller: courseNameController,
                decoration: InputDecoration(
                  hintText: "Enter course name",
                ),
              ),
              SizedBox(height: 16.0),
              Text("Course Description:"),
              TextFormField(
                controller: courseDescController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Enter course description",
                ),
              ),
              SizedBox(height: 16.0),
              Text("Course Fees:"),
              TextFormField(
                controller: courseFeesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter course fees",
                ),
              ),
              SizedBox(height: 16.0),
              Text("Course Duration:"),
              TextFormField(
                controller: courseDurationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter course duration",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement update course functionality
                String updatedCourseName = courseNameController.text;
                String updatedCourseDesc = courseDescController.text;
                double updatedCourseFees =
                    double.parse(courseFeesController.text);
                int updatedCourseDuration =
                    int.parse(courseDurationController.text);

                final courseData = CourseModel(
                  id: course.id,
                  imgUrl: course.imgUrl,
                  userId: course.userId,
                  starDate: course.starDate,
                  courseName: updatedCourseName,
                  desc: updatedCourseDesc,
                  duration: updatedCourseDuration,
                  fees: updatedCourseFees.toInt(),
                );

                // You can use these updated values to update the course
                // For example: controller.updateCourse(course.id, updatedCourseName, updatedCourseDesc, updatedCourseFees, updatedCourseStartDate, updatedCourseDuration);
                controller.updateCourse(courseData);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Course updated successfully!"),
                  ),
                );
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<CourseModel>>(
          future: controller.getCureses(user!.uid),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (c, index) {
                          return Column(
                            children: [
                              Container(
                                height: 200,
                                child: Image.network(
                                  snapshot.data![index].imgUrl.toString(),
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return CircularProgressIndicator();
                                  },
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        snapshot.data![index].courseName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          10.0, 0, 10.0, 10.0),
                                      child: Text(
                                        snapshot.data![index].desc,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Show the "Update" button only if the user's role is "admin" or "staff"

                                        ElevatedButton(
                                          child: Text("Update"),
                                          onPressed: () {
                                            _showUpdateCourseDialog(
                                                context, snapshot.data![index]);
                                          },
                                        ),
                                        SizedBox(width: 10.0),
                                        ElevatedButton(
                                          child: Text("Add Lecture"),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AddLectureForm(
                                                  courseId: snapshot
                                                      .data![index].id
                                                      .toString(),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        SizedBox(width: 10.0),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedCourse =
                                                  snapshot.data![index];
                                            });
                                            _showCourseDetailsDialog(context);
                                          },
                                          child: Text('View Details'),
                                        ),
                                        SizedBox(width: 10.0),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddCourseForm();
            },
          );
        },
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
