import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management/models/team.dart';

class ManageTeam extends StatelessWidget {
  ManageTeam({super.key});
  final _firestore = FirebaseFirestore.instance;
  Future<List<Team>> fetchTeams() async {
    final collection = await _firestore.collection("teams").get();
    final docs = collection.docs.map((doc) => doc.data()).toList();
    final res = docs.map((element) => Team.fromJson(element)).toList();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Team"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: fetchTeams(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: snapshot.data!
                      .map((team) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TeamWidget(
                              teamName: team.name,
                            ),
                          ))
                      .toList(),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class TeamWidget extends StatelessWidget {
  const TeamWidget({
    super.key,
    required this.teamName,
  });
  final String teamName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black12,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  teamName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Text(
                  'Active',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text('20/9/2024')
          ],
        ),
      ),
    );
  }
}
