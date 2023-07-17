import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:DLP/screens/admin/controllers/profile_controller.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class AccountPage extends StatelessWidget {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: controller.getUserData(currentUser?.email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Container(
                    child: Form(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 200,
                              child: Lottie.asset(getImageUrl("Male")),
                            ),
                            if (userData.userType ==
                                'student') // check if user is a student
                              GestureDetector(
                                onTap: () async {
                                  // handle click event

                                  // print(userData.id);
                                  controller.updateUser1(userData);
                                },
                                child: Text(
                                  'Become an Instructor',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 128, 194, 255),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            SizedBox(height: 10.0),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  initialValue: userData.fullName,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  initialValue: userData.email,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Email',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  initialValue: userData.phoneNo,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Mobile',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  initialValue: userData.userId,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'User ID',
                                  ),
                                  enabled: false,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () {}, child: Text("Edit Profile")),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Center(child: Text("Something went wrong!"));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  String getImageUrl(String gender) {
    if (gender == 'Male') {
      return 'assets/profile.json';
    } else {
      return 'assets/female.json';
    }
  }
}
