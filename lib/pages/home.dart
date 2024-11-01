import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:task_management/models/user.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/pages/create_personnel.dart';
import 'package:task_management/pages/manage_tasks.dart';
import 'package:task_management/pages/manage_personnel.dart';
import 'package:task_management/pages/profile.dart';
import 'package:task_management/widgets/action_cards.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Future<UserData> fetchUser() async {
    final res =
        await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    return UserData.fromJson({...res.data()!, "id": res.id});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       const Text('Hello!'),
      //       FutureBuilder(
      //           future: fetchUser(),
      //           builder: (context, snapshot) {
      //             if (snapshot.hasData) {
      //               return Text(snapshot.data!.name);
      //             }
      //             return const Text('Loading');
      //           }),
      //     ],
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {}, icon: const Icon(Icons.notifications_on)),
      //     InkWell(
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => const Profile(),
      //           ),
      //         );
      //       },
      //       child: const Padding(
      //         padding: EdgeInsets.all(8.0),
      //         child: CircleAvatar(
      //           foregroundImage: NetworkImage(
      //               'https://lh3.googleusercontent.com/ogw/AF2bZyiJ2kY8IZ_zi4xV5r2fY-2O_ZZ8y0gtTcE34XqLyXfpcKk=s64-c-mo'),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/home.jpeg",
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: const Color.fromRGBO(0, 0, 0, .5),
                  width: double.infinity,
                  height: 400,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: ActionCard(
                              title: "Create Task", page: CreateTask())),
                      SizedBox(width: 12),
                      Expanded(
                          child: ActionCard(
                              title: "Manage Task", page: ManageTask())),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ActionCard(
                              title: "Create Personnel",
                              page: CreatePersonnel())),
                      const SizedBox(width: 12),
                      Expanded(
                          child: ActionCard(
                              title: "Manage Personnel",
                              page: ManagePersonnel())),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    super.key,
  });
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 48,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTask(),
                ),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.add),
              title: Text('Create Task'),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageTask(),
                ),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.manage_history),
              title: Text('Manage Task'),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePersonnel(),
                ),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.people),
              title: Text('Create Personnel'),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManagePersonnel(),
                ),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Manage Personnel'),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.person),
              title: Text('View Profile'),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignIn(),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _auth.signOut(),
            ),
          ),
        ],
      )),
    );
  }
}
