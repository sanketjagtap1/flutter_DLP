import 'package:DLP/screens/student/model/enroll_model.dart';
import 'package:DLP/screens/teacher/controller/teacher_controller.dart';
import 'package:DLP/screens/teacher/model/course_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:DLP/screens/student/controller/student_controller.dart';
import 'package:uuid/uuid.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _formKey = GlobalKey<FormState>();
  // final teacherRepo = Get.put(TeacherRepository());

  final _cardNoController = TextEditingController();
  final _cardHolderNameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final studentController = Get.put(StudentController());
    final currentUser = FirebaseAuth.instance.currentUser;
    String formatDate(String dateString) {
      final inputFormat = DateFormat('yyyy-MM-dd');
      final outputFormat = DateFormat('dd/MM/yyyy');
      final date = inputFormat.parse(dateString);
      return outputFormat.format(date);
    }

    // functions

    void _showPaymentPopup(CourseModel course) {
      _amountController.text = course.fees.toString();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: _cardNoController,
                        maxLength: 16,
                        decoration: InputDecoration(
                          labelText: 'Card No',
                          hintText: '1234 1234 1234 1234',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a card no';
                          } else if (value.length < 16 || value.length > 16) {
                            return 'Please enter a valid card no';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _cardHolderNameController,
                        maxLength: 30,
                        decoration: InputDecoration(
                          labelText: 'Card Holder Name',
                          hintText: 'Ex. sam ',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _amountController,
                        maxLength: 10,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          hintText: '',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a course fees';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _expiryDateController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'Expiry Date',
                          hintText: '01/27',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a course duration';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _cvvController,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          hintText: '123',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a cvv';
                          }
                          if (value.length > 3 || value.length < 3) {
                            return 'Please enter a valid cvv';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              _amountController.clear();
                              _cardNoController.clear();
                              _cardHolderNameController.clear();
                              _cvvController.clear();
                              _expiryDateController.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: Text('Pay & Enroll'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final userId =
                                    FirebaseAuth.instance.currentUser!.uid;

                                // TODO: Handle saving the course data
                                var email = currentUser!.email;
                                var uid = currentUser.uid;

                                final data = EnrollModel(
                                    id: Uuid().v4(),
                                    courseId: course.id.toString(),
                                    email: email.toString(),
                                    amount: course.fees.toString(),
                                    paymentStatus: "true",
                                    cardNo: _cardNoController.text.trim(),
                                    studentId: uid.toString(),
                                    createdDate: DateTime.now().toString());

                                studentController.enrollCourse(data);
                                _amountController.clear();
                                _cardNoController.clear();
                                _cardHolderNameController.clear();
                                _cvvController.clear();
                                _expiryDateController.clear();
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    void _showCourseDetails(CourseModel course) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: IntrinsicHeight(
              child: Card(
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
                      child: Image.network(
                        'https://images.alphacoders.com/889/889210.png',
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 10.0, 6.0),
                      child: Center(
                        child: Text(
                          course.courseName,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description: ",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(course.desc)
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start Date: ",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(formatDate(course.starDate))
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fees: ",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text("${course.fees.toString()} /-")
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Duration: ",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text("${course.duration.toString()} Hours"),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _showPaymentPopup(course);
                              },
                              child: Text("Enroll Now"),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    final controller = Get.put(TeacherController());
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<CourseModel>>(
            future: controller.getAllCourses(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
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
                                    child: Image.network(
                                      'https://images.alphacoders.com/889/889210.png',
                                      height: 120.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16.0, 16.0, 10.0, 6.0),
                                    child: Center(
                                      child: Text(
                                        snapshot.data![index].courseName,
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
                                      "Description: ${snapshot.data![index].desc}",
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
                                      "Start Date: ${formatDate(snapshot.data![index].starDate)}",
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
                                            _showCourseDetails(
                                                snapshot.data![index]);
                                          },
                                          child: Text("Show Details"))),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Center(child: Text("Something went wrong!"));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            })),
      )),
    );
  }
}
