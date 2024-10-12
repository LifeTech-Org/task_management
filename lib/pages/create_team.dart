import 'package:flutter/material.dart';
import 'package:task_management/models/personnel.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateTeam extends StatefulWidget {
  CreateTeam({super.key});

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _personnelController = TextEditingController();

  List<Personnel> personnels = [];

  final _firestore = FirebaseFirestore.instance;

  void createTeam() async {
    await _firestore.collection("teams").add({
      "name": _nameController.text.trim(),
      "description": _descriptionController.text.trim(),
      "personnels": personnels.map((personnel) => personnel.name).toList(),
    });
  }

  void addPersonnel() {
    setState(() {
      personnels.add(Personnel(name: _personnelController.text.trim()));
      _personnelController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Team"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomFormField(
              title: "Team Name",
              form: CustomTextField(
                controller: _nameController,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomFormField(
              title: "Team Description",
              form: CustomTextField(
                maxLines: 4,
                controller: _descriptionController,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: personnels
                  .map((personnel) => Row(
                        children: [
                          Text(personnel.name),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  personnels = personnels
                                      .where((p) => p.name != personnel.name)
                                      .toList();
                                });
                              },
                              icon: const Icon(Icons.cancel))
                        ],
                      ))
                  .toList(),
            ),
            CustomFormField(
              title: "Personnel",
              form: CustomTextField(
                maxLines: 4,
                controller: _personnelController,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomButton(text: 'Create', action: () {})
          ],
        ),
      ),
    );
  }
}
