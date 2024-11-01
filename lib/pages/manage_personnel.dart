import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/models/personnel.dart';
import 'package:task_management/pages/edit_personnel.dart';
import 'package:url_launcher/url_launcher.dart';

class ManagePersonnel extends StatelessWidget {
  ManagePersonnel({super.key});
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchPersonnels() {
    return _firestore
        .collection("personnels")
        .where("userId", isEqualTo: _auth.currentUser!.uid)
        .snapshots();
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
        child: StreamBuilder(
          stream: fetchPersonnels(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final personels = snapshot.data!.docs
                  .map((doc) => {...doc.data(), "id": doc.id})
                  .map((json) => Personnel.fromJson(json))
                  .toList();
              return SingleChildScrollView(
                child: Column(
                  children: personels!
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
  PersonnelWidget({
    super.key,
    required this.personnel,
  });
  final Personnel personnel;
  final _firestore = FirebaseFirestore.instance;

  void makePhoneCall() async {
    await launchUrl(Uri(
      scheme: 'tel',
      path: personnel.phoneNumber,
    ));
  }

  void deletePersonnel(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Do you want to delete this personnel?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              TextButton(
                  onPressed: () async {
                    await _firestore
                        .collection("personnels")
                        .doc(personnel.id)
                        .delete();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Personnel deleted successfully!')));
                    Navigator.pop(context);
                  },
                  child: const Text('Yes'))
            ],
          );
        });
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
                ),
                IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    deletePersonnel(context);
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
