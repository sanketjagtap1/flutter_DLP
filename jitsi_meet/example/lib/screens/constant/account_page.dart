import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:DLP/screens/admin/controllers/profile_controller.dart';
import 'package:lottie/lottie.dart';

class AccountPage extends StatelessWidget {
  var currentUser = FirebaseAuth.instance.currentUser;
  final controller = Get.put(ProfileController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: controller.getUserData(currentUser?.email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;

                  nameController.text = userData.fullName ?? '';
                  emailController.text = userData.email ?? '';
                  phoneNoController.text = userData.phoneNo ?? '';

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
                            if (userData.userType == 'student')
                              GestureDetector(
                                onTap: () async {
                                  // handle click event
                                  controller.updateUser(userData);
                                },
                                child: Text(
                                  'Become an Instructor',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
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
                                  controller: nameController,
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
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Email',
                                  ),
                                  enabled: false,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  controller: phoneNoController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Mobile',
                                  ),
                                  enabled: false,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                // Handle edit profile button click

                                // Retrieve updated values from the form
                                String updatedName = nameController.text;
                                String updatedEmail = emailController.text;
                                String updatedPhoneNo = phoneNoController.text;

                                // Update the user data
                                UserModel updatedUserData = UserModel(
                                  id: userData.id,
                                  fullName: updatedName,
                                  email: updatedEmail,
                                  phoneNo: updatedPhoneNo,
                                  password: userData
                                      .password, // Add the missing password field
                                  userId: userData.userId,
                                  userType: userData.userType,
                                );
                                await controller.updateUser(updatedUserData);

                                // Show a snackbar or perform any other action to indicate the profile update success
                                Get.snackbar(
                                    'Success', 'Profile updated successfully');
                              },
                              child: Text("Edit Profile"),
                            ),
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
