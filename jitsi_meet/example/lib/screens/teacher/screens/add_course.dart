import 'package:flutter/material.dart';

class AddCourseForm extends StatefulWidget {
  const AddCourseForm({Key? key}) : super(key: key);

  @override
  _AddCourseFormState createState() => _AddCourseFormState();
}

class _AddCourseFormState extends State<AddCourseForm> {
  final _formKey = GlobalKey<FormState>();
  final _courseNameController = TextEditingController();
  final _startDateController = TextEditingController();
  final _courseDescriptionController = TextEditingController();
  final _feesController = TextEditingController();
  final _durationController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _courseNameController.dispose();
    _startDateController.dispose();
    _courseDescriptionController.dispose();
    _feesController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _startDateController.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _courseNameController,
              decoration: InputDecoration(
                labelText: 'Course Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a course name';
                }
                return null;
              },
            ),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: _startDateController,
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a start date';
                    }
                    return null;
                  },
                ),
              ),
            ),
            TextFormField(
              controller: _courseDescriptionController,
              decoration: InputDecoration(
                labelText: 'Course Description',
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
              decoration: InputDecoration(
                labelText: 'Fees',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a fees amount';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _durationController,
              decoration: InputDecoration(
                labelText: 'Duration',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a course duration';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: save the course to the database or somewhere else
                  Navigator.pop(context);
                }
              },
              child: Text('Save Course'),
            ),
          ],
        ),
      ),
    );
  }
}
