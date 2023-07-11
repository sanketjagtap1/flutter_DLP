import 'package:DLP/screens/admin/controllers/profile_controller.dart';
import 'package:DLP/screens/admin/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<UserModel>>(
            future: controller.getAllTeacherUsers(),
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
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.check),
                                    onPressed: () {
                                      // Handle approve button press
                                      controller.updateUser(
                                        snapshot.data as UserModel,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      // Handle reject button press
                                      controller.updateUser(
                                        snapshot.data as UserModel,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Confirm Deletion'),
                                          content: Text(
                                              'Are you sure you want to delete this user?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                controller.deleteUser(
                                                    snapshot.data![index].id);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Center(child: Text("Something went wrong!"));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ),
      ),
    );
  }
}
