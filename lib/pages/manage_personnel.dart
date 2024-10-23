import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management/models/personnel.dart';
import 'package:task_management/pages/edit_personnel.dart';
import 'package:url_launcher/url_launcher.dart';

class ManagePersonnel extends StatelessWidget {
  ManagePersonnel({super.key});
  final _firestore = FirebaseFirestore.instance;
  Future<List<Personnel>> fetchPersonnels() async {
    final collection = await _firestore.collection("personnels").get();
    final docs =
        collection.docs.map((doc) => {...doc.data(), "id": doc.id}).toList();
    final res = docs.map((element) => Personnel.fromJson(element)).toList();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Personnel"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: fetchPersonnels(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: snapshot.data!
                      .map((personnel) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: PersonnelWidget(
                              personnel: personnel,
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

class PersonnelWidget extends StatelessWidget {
  const PersonnelWidget({
    super.key,
    required this.personnel,
  });
  final Personnel personnel;

  void makePhoneCall() async {
    await launchUrl(Uri(
      scheme: 'tel',
      path: personnel.phoneNumber,
    ));
  }

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  personnel.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  personnel.phoneNumber,
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    makePhoneCall();
                  },
                  icon: const Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.green.shade800),
                ),
                IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPersonnelLayout(
                          id: personnel.id,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.blue.shade800),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
