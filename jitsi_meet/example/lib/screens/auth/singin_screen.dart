// ignore: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_example/screens/auth/forgot_password_screen.dart';
import 'package:jitsi_meet_example/screens/auth/signup_screen.dart';
import 'package:jitsi_meet_example/services/signup_service.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Sign In"),
        // actions: [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            const SizedBox(
              height: 30.0,
            ),
            Container(
              alignment: Alignment.center,
              height: 250,
              child: Lottie.asset("assets/107800-login-leady.json"),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: loginEmailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email), hintText: 'Email'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: loginPasswordController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility),
                    hintText: 'Password'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  var username = loginEmailController.text.trim();
                  var password = loginPasswordController.text.trim();

                  signInUser(username, password, context);
                },
                child: const Text("Login")),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () => {Get.to(() => ForgotPasswordScreen())},
              child: const Card(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Forgot Password"),
              )),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => SignupScreen());
              },
              child: const Card(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Don't have an account? Sign Up"),
              )),
            )
          ]),
        ),
      ),
    );
  }
}
