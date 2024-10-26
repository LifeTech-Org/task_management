import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';

class ManageTask extends StatelessWidget {
  ManageTask({super.key});

  final _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchTasks() {
    return _firestore.collection("tasks").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Manage Task"),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: fetchTasks(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final tasks = snapshot.data!.docs
                    .map((doc) => {...doc.data(), "id": doc.id})
                    .map((json) => Task.fromJson(json))
                    .toList();
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: tasks
                          .map((task) => Column(
                                children: [
                                  TaskWidget(
                                    task: task,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

class TaskWidget extends StatelessWidget {
  TaskWidget({
    super.key,
    required this.task,
  });

  final _firestore = FirebaseFirestore.instance;
  void deleteTask(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Do you want to delete this task?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              TextButton(
                  onPressed: () async {
                    await _firestore.collection("tasks").doc(task.id).delete();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Task deleted successfully!')));
                    Navigator.pop(context);
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }

  final Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: task.isMarkedDone ? Colors.blue : Colors.black12,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.date_range,
                          size: 16,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          formatDate(task.date),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.timelapse,
                          size: 16,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          formatTime(task.start),
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Text('-'),
                        Text(
                          formatTime(task.end),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    // makePhoneCall();
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.green.shade800),
                ),
                IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditPersonnelLayout(
                    //       id: personnel.id,
                    //     ),
                    //   ),
                    // );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.blue.shade800),
                ),
                IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    deleteTask(context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.red.shade800),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
