import 'package:flutter/material.dart';

class ManageTeam extends StatelessWidget {
  const ManageTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Team"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Team(),
              SizedBox(
                height: 12,
              ),
              Team(),
              SizedBox(
                height: 12,
              ),
              Team(),
              SizedBox(
                height: 12,
              ),
              Team(),
              SizedBox(
                height: 12,
              ),
              Team(),
              SizedBox(
                height: 12,
              ),
              Team(),
              SizedBox(
                height: 12,
              ),
              Team(),
              SizedBox(
                height: 12,
              ),
              Team(),
              SizedBox(
                height: 12,
              ),
              Team(),
              SizedBox(
                height: 12,
              ),
              Team(),
              SizedBox(
                height: 12,
              ),
              Team(),
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

class Team extends StatelessWidget {
  const Team({
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
                  'Team Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Active',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text('20/9/2024')
          ],
        ),
      ),
    );
  }
}
