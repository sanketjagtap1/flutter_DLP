// ignore_for_file: unused_field, unused_element, deprecated_member_use

import 'dart:io';
import 'package:DLP/screens/teacher/repository/teacher_repository.dart';
import 'package:DLP/screens/teacher/model/course_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCourseForm extends StatefulWidget {
  @override
  _AddCourseFormState createState() => _AddCourseFormState();
}

class _AddCourseFormState extends State<AddCourseForm> {
  final _formKey = GlobalKey<FormState>();
  final teacherRepo = Get.put(TeacherRepository());

  final _courseNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _feesController = TextEditingController();
  final _durationController = TextEditingController();
  final _startDateController = TextEditingController();

  DateTime? _selectedDate;
  File? _selectedImage;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3000));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _startDateController.text = DateFormat.yMd().format(_selectedDate!);
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _courseNameController.dispose();
    _descriptionController.dispose();
    _feesController.dispose();
    _durationController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Dialog(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: _courseNameController,
                    maxLength: 30,
                    decoration: InputDecoration(
                      labelText: 'Course Name',
                      hintText: 'Enter course name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a course name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    maxLength: 200,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter course description',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a course description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _feesController,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'Fees',
                      hintText: 'Enter course fees',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a course fees';
                      }
                      return null;
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _startDateController,
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          hintText: 'Select start date',
                        ),
                        validator: (value) {
                          // ignore: unnecessary_null_comparison
                          if (_selectedDate == null) {
                            return 'Please select a start date';
                          }
                          if (_selectedDate!.isBefore(DateTime.now())) {
                            return 'Please select a date from today or later';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        _pickImage();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add_photo_alternate),
                          SizedBox(width: 8.0),
                          Text('Select Image'),
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _durationController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Duration (in hours)',
                      hintText: 'Enter course duration',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a course duration';
                      }
                      final duration = int.tryParse(value);
                      if (duration == null || duration <= 0) {
                        return 'Please enter a valid course duration';
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
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: Text('Add'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final userId =
                                FirebaseAuth.instance.currentUser!.uid;
                            final courseName = _courseNameController.text;
                            final description = _descriptionController.text;
                            final startDate = _selectedDate;
                            final image = _selectedImage;
                            final duration =
                                int.parse(_durationController.text);
                            final fees = int.parse(_feesController.text);

                            final courseData = CourseModel(
                                id: Uuid().v4(),
                                courseName: courseName,
                                desc: description,
                                starDate: startDate.toString(),
                                duration: duration,
                                userId: userId,
                                imgUrl: image.toString(),
                                fees: fees);

                            // TODO: Handle saving the course data
                            teacherRepo.createCourse(courseData);
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
}
