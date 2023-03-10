import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  // const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? userData = FirebaseAuth.instance.currentUser;
  final CollectionReference myCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    print("---userData--->> ${userData?.uid}");

    // final fil_data = myCollection.where(
    //     (x) => x.uid.toLowerCase().contains('GnPntWZ1gwdbyrrQdQVXXHtYzgY2'));
    // print('----filter data--: $fil_data');
    // FirebaseFirestore.instance
    //     .collection("users")
    //     .where(userId, isEqualTo: userId.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: FutureBuilder<QuerySnapshot>(
        future: myCollection.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot document = snapshot.data!.docs[index];
              final Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['userName']),
                // title: Text(data['title']),
                // subtitle: Text(data['description']),
              );
            },
          );
        },
      )),
    );
  }
}
