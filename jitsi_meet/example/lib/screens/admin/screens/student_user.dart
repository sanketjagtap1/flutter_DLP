import 'package:DLP/screens/admin/controllers/profile_controller.dart';
import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class studentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<UserModel>>(
            future: controller.getAllUsers(),
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
                              child: ListTile(
                                iconColor: Colors.blue,
                                leading: Icon(Icons.person),
                                title: Text(snapshot.data![index].fullName),
                                subtitle: Text(snapshot.data![index].email),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                ),
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
