import 'package:flutter/material.dart';
import 'package:task_management/models/personnel.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/pages/manage_personnel.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePersonnel extends StatefulWidget {
  const CreatePersonnel({super.key});

  @override
  State<CreatePersonnel> createState() => _CreatePersonnelState();
}

class _CreatePersonnelState extends State<CreatePersonnel> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _roleController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  List<Personnel> personnels = [];

  final _firestore = FirebaseFirestore.instance;

  bool _isCreatingPersonnel = false;

  void createPersonnel(BuildContext context) async {
    try {
      setState(() {
        _isCreatingPersonnel = true;
      });
      await _firestore.collection("personnels").add({
        "name": _nameController.text.trim(),
        "role": _roleController.text.trim(),
        "phoneNumber": _phoneNumberController.text.trim(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Personnel successfully created!!!')));
      setState(() {
        _isCreatingPersonnel = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ManagePersonnel(),
        ),
      );
    } catch (e) {
      setState(() {
        _isCreatingPersonnel = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong...')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Personnel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomFormField(
                title: "Name",
                form: CustomTextField(
                  controller: _nameController,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomFormField(
                title: "Role",
                form: CustomTextField(
                  controller: _roleController,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomFormField(
                title: "Phone Number",
                form: CustomTextField(
                  controller: _phoneNumberController,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 32,
              ),
              CustomButton(
                text: 'Create Personnel',
                action: () {
                  createPersonnel(context);
                },
                isLoading: _isCreatingPersonnel,
              )
            ],
          ),
        ),
      ),
    );
  }
}
