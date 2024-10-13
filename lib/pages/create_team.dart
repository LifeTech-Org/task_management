import 'package:flutter/material.dart';
import 'package:task_management/models/personnel.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({super.key});

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _personnelController = TextEditingController();

  List<Personnel> personnels = [];

  final _firestore = FirebaseFirestore.instance;

  bool _isCreatingTeam = false;

  void createTeam(BuildContext context) async {
    try {
      setState(() {
        _isCreatingTeam = true;
      });
      await _firestore.collection("teams").add({
        "name": _nameController.text.trim(),
        "description": _descriptionController.text.trim(),
        "personnels": personnels.map((personnel) => personnel.name).toList(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Team successfully created!!!')));
      setState(() {
        _isCreatingTeam = false;
      });
    } catch (e) {
      setState(() {
        _isCreatingTeam = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong...')));
    }
  }

  void addPersonnel() {
    if (_personnelController.text.trim().isEmpty) return;
    setState(() {
      personnels.add(Personnel(name: _personnelController.text.trim()));
      _personnelController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Team"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
                            Expanded(child: Text(personnel.name)),
                            const SizedBox(
                              width: 6,
                            ),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomFormField(
                      title: "Personnel",
                      form: CustomTextField(
                        controller: _personnelController,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton(
                      onPressed: addPersonnel, icon: const Icon(Icons.add))
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              CustomButton(
                text: 'Create',
                action: () {
                  createTeam(context);
                },
                isLoading: _isCreatingTeam,
              )
            ],
          ),
        ),
      ),
    );
  }
}
