import 'package:DLP/screens/teacher/controller/teacher_controller.dart';
import 'package:DLP/screens/teacher/model/lecture_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddLectureForm extends StatefulWidget {
  final String courseId;
  const AddLectureForm({Key? key, required this.courseId}) : super(key: key);
  @override
  _AddLectureFormState createState() => _AddLectureFormState();
}

class _AddLectureFormState extends State<AddLectureForm> {
  final _formKey = GlobalKey<FormState>();
  late String _lectureTitle;
  late DateTime _date;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _date = DateTime.now();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: today,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  String extractTimeFromTimeOfDay(String timeOfDayString) {
    RegExp regExp = new RegExp(r'\((.*?)\)');
    String time = regExp.firstMatch(timeOfDayString)?.group(1) ?? '';

    print(time);
    return time;
  }

  User? user = FirebaseAuth.instance.currentUser;
  final teacherController = Get.put(TeacherController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Lecture'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter lecture title',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter lecture title';
                }
                return null;
              },
              onSaved: (value) {
                _lectureTitle = value!;
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Date:'),
                SizedBox(width: 20),
                TextButton(
                  child: Text(DateFormat('EEE, MMM d, y').format(_date)),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Start Time:'),
                SizedBox(width: 20),
                TextButton(
                  child: Text(_startTime.format(context)),
                  onPressed: () {
                    _selectStartTime(context);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('End Time:'),
                SizedBox(width: 20),
                TextButton(
                  child: Text(_endTime.format(context)),
                  onPressed: () {
                    _selectEndTime(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              print(_lectureTitle);
              print(_date);
              print(_endTime);
              print(_startTime);
              final lectureData = LectureModel(
                  id: Uuid().v4(),
                  lectureTitle: _lectureTitle,
                  courseId: widget.courseId,
                  teacherId: user!.uid,
                  date: _date.toString(),
                  startTime: extractTimeFromTimeOfDay(_startTime.toString()),
                  endTime: extractTimeFromTimeOfDay(_endTime.toString()));

              teacherController.sendMail(lectureData);
              // Do something with the lecture data, e.g. save to database
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}



// import 'package:DLP/screens/teacher/controller/teacher_controller.dart';
// import 'package:DLP/screens/teacher/model/lecture_model.dart';
// import 'package:DLP/screens/teacher/repository/teacher_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AddLecturePopup extends StatefulWidget {
//   final String courseId;

//   const AddLecturePopup({Key? key, required this.courseId}) : super(key: key);

//   @override
//   _AddLecturePopupState createState() => _AddLecturePopupState();
// }

// class _AddLecturePopupState extends State<AddLecturePopup> {
//   final _formKey = GlobalKey<FormState>();
//   late String _lectureTitle;
//   late DateTime _lectureDateTime;
//   late TimeOfDay _lectureStartTime;
//   late TimeOfDay _lectureEndTime;
//   final teacherRepo = Get.put(TeacherRepository());

//   TextEditingController _dateController = TextEditingController();
//   TextEditingController _startTimeController = TextEditingController();
//   TextEditingController _endTimeController = TextEditingController();

//   @override
//   void initState() {
//     // TODO: implement initState
//     print("Course ID: ${widget.courseId}");
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _dateController.dispose();
//     _startTimeController.dispose();
//     _endTimeController.dispose();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text("Add Lecture"),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: "Lecture Title"),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Please enter lecture title";
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 _lectureTitle = value!;
//               },
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               decoration: InputDecoration(labelText: "Lecture Date"),
//               controller: _dateController,
//               onTap: () async {
//                 final pickedDate = (await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime(2100),
//                 ));
//                 if (pickedDate != null) {
//                   setState(() {
//                     _lectureDateTime = pickedDate;
//                     _dateController.text = _lectureDateTime.toString();
//                   });
//                 }
//               },
//               validator: (value) {
//                 if (_lectureDateTime == null) {
//                   return "Please select lecture date";
//                 }
//                 return null;
//               },
//               readOnly: true,
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               decoration: InputDecoration(labelText: "Lecture Start Time"),
//               controller: _startTimeController,
//               onTap: () async {
//                 final pickedTime = await showTimePicker(
//                   context: context,
//                   initialTime: TimeOfDay.now(),
//                 );
//                 if (pickedTime != null) {
//                   setState(() {
//                     _lectureStartTime = pickedTime;
//                     _startTimeController.text =
//                         _lectureStartTime.hour.toString() +
//                             ':' +
//                             _lectureStartTime.minute.toString();
//                   });
//                 }
//               },
//               validator: (value) {
//                 if (_lectureStartTime == null) {
//                   return "Please select lecture start time";
//                 }
//                 return null;
//               },
//               readOnly: true,
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               decoration: InputDecoration(labelText: "Lecture End Time"),
//               controller: _endTimeController,
//               onTap: () async {
//                 final pickedTime = await showTimePicker(
//                   context: context,
//                   initialTime: TimeOfDay.now(),
//                 );
//                 if (pickedTime != null) {
//                   setState(() {
//                     _lectureEndTime = pickedTime;
//                     _endTimeController.text = _lectureEndTime.hour.toString() +
//                         ':' +
//                         _lectureEndTime.minute.toString();
//                   });
//                 }
//               },
//               validator: (value) {
//                 if (_lectureEndTime == null) {
//                   return "Please select lecture end time";
//                 }
//                 return null;
//               },
//               readOnly: true,
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         ElevatedButton(
//           child: Text("Cancel"),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         ElevatedButton(
//           child: Text("Add"),
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               _formKey.currentState!.save();
//               // TODO: add lecture to database with courseId
//               print("Course ID: ${widget.courseId}");
//               print("Lecture Title: $_lectureTitle");
//               print("Lecture Date: ${_dateController.text}");
//               print("Lecture StartTime: ${_startTimeController.text}");
//               print("Lecture EndTime: ${_endTimeController.text}");

//               var data = LectureModel(
//                   lectureTitle: _lectureTitle,
//                   date: _dateController.text.toString(),
//                   startTime: _startTimeController.text.toString(),
//                   endTime: _endTimeController.text,
//                   courseId: widget.courseId);

//               // teacherRepo.addLecture(data);
//               teacherController.sendMail(data);
//               Navigator.of(context).pop();
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
