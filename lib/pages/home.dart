import 'package:flutter/material.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/pages/create_team.dart';
import 'package:task_management/pages/manage_task.dart';
import 'package:task_management/pages/manage_team.dart';
import 'package:task_management/pages/profile.dart';
import 'package:task_management/widgets/action_cards.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello!'),
            Text('Esther Howard'),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_on)),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                foregroundImage: NetworkImage(
                    'https://lh3.googleusercontent.com/ogw/AF2bZyiJ2kY8IZ_zi4xV5r2fY-2O_ZZ8y0gtTcE34XqLyXfpcKk=s64-c-mo'),
              ),
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Expanded(
                    child:
                        ActionCard(title: "Create Task", page: CreateTask())),
                SizedBox(width: 12),
                Expanded(
                    child:
                        ActionCard(title: "Manage Task", page: ManageTask())),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                    child:
                        ActionCard(title: "Create Team", page: CreateTeam())),
                SizedBox(width: 12),
                Expanded(
                    child:
                        ActionCard(title: "Manage Team", page: ManageTeam())),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

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
                  builder: (context) => const Home(),
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
                  builder: (context) => const CreateTask(),
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
                  builder: (context) => const ManageTask(),
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
                  builder: (context) => const CreateTeam(),
                ),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.people),
              title: Text('Create Team'),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageTeam(),
                ),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Manage Team'),
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
            child: const ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ),
        ],
      )),
    );
  }
}