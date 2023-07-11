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
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherController());
    final user = FirebaseAuth.instance.currentUser;
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
                                  snapshot.data![index].imgUrl,
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
                                        ElevatedButton(
                                          child: Text("Update"),
                                          onPressed: () {
                                            // TODO: implement update button functionality
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
}
