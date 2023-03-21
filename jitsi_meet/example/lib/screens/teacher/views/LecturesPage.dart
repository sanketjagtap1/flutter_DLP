import 'package:DLP/meeting.dart';
import 'package:DLP/screens/student/controller/student_controller.dart';
import 'package:DLP/screens/teacher/model/lecture_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LecturesPage extends StatefulWidget {
  const LecturesPage({Key? key}) : super(key: key);

  @override
  State<LecturesPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LecturesPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentController());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<LectureModel>>(
          future: controller.getTeacherLectures(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (c, index) {
                    return Column(
                      children: [
                        Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "${snapshot.data![index].lectureTitle}",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        height: 5),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 6.0),
                                child: Center(
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16),
                                child: Text(
                                  "Start Date : ${snapshot.data![index].date}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16),
                                child: Text(
                                  "Start Date and Time: ${snapshot.data![index].startTime}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16),
                                child: Text(
                                  "End Date and Time: ${snapshot.data![index].endTime}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // TODO: Implement join meeting functionality
                                    Get.to(Meeting(
                                        roomId:
                                            snapshot.data![index].id.toString(),
                                        title: snapshot
                                            .data![index].lectureTitle));
                                  },
                                  child: Text("Join Meeting"),
                                ),
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
    );
  }
}
