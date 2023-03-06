// ignore: file_names
// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_example/screens/auth/singin_screen.dart';
import 'package:jitsi_meet_example/services/signup_service.dart';
import 'package:lottie/lottie.dart';
import 'dart:developer';

class SignupScreen extends StatefulWidget {
  // const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        centerTitle: true,
        title: Text("Sign Up"),
        // actions: [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            const SizedBox(
              height: 5.0,
            ),
            Container(
              alignment: Alignment.center,
              height: 250,
              child: Lottie.asset("assets/38435-register.json"),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: userNameController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person), hintText: 'Name'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: emailController,
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
                controller: mobileController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone), hintText: 'Mobile'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: passwordController,
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
                  var userName = userNameController.text.trim();
                  var email = emailController.text.trim();
                  var mobile = mobileController.text.trim();
                  var password = passwordController.text.trim();

                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password)
                      .then((value) => {
                            log("User Created"),
                            sugnUpUser(userName, email, mobile, password),
                          });
                },
                child: const Text("Sign Up ")),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => LoginScreen());
              },
              child: const Card(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Already have an account? Sign In"),
              )),
            )
          ]),
        ),
      ),
    );
  }
}
