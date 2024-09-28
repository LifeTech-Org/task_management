import 'package:flutter/material.dart';

class ManageTask extends StatelessWidget {
  const ManageTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Task"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Task(),
              SizedBox(
                height: 12,
              ),
              Task(),
              SizedBox(
                height: 12,
              ),
              Task(),
              SizedBox(
                height: 12,
              ),
              Task(),
              SizedBox(
                height: 12,
              ),
              Task(),
              SizedBox(
                height: 12,
              ),
              Task(),
              SizedBox(
                height: 12,
              ),
              Task(),
              SizedBox(
                height: 12,
              ),
              Task(),
              SizedBox(
                height: 12,
              ),
              Task(),
              SizedBox(
                height: 12,
              ),
              Task(),
              SizedBox(
                height: 12,
              ),
              Task(),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Task extends StatelessWidget {
  const Task({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black12,
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text('03h:00m:00s'),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text('11AM to 12PM of Date 16/9/2024'),
                Text(
                  'Active',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
