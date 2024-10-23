import 'package:flutter/material.dart';
import 'package:task_management/models/personnel.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPersonnelLayout extends StatefulWidget {
  const EditPersonnelLayout({super.key, required this.id});
  final String id;
  @override
  State<EditPersonnelLayout> createState() => _EditPersonnelLayoutState();
}

class _EditPersonnelLayoutState extends State<EditPersonnelLayout> {
  List<Personnel> personnels = [];

  final _firestore = FirebaseFirestore.instance;

  Future<Personnel> fetchPersonnel() async {
    final res = await _firestore.collection("personnels").doc(widget.id).get();

    return Personnel.fromJson({...res.data()!, "id": widget.id});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Personnel"),
        ),
        body: FutureBuilder(
            future: fetchPersonnel(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return EditPersonnel(personnel: snapshot.data!);
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}

class EditPersonnel extends StatefulWidget {
  EditPersonnel({super.key, required this.personnel});
  final Personnel personnel;

  @override
  State<EditPersonnel> createState() => _EditPersonnelState();
}

class _EditPersonnelState extends State<EditPersonnel> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _roleController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;
  bool _isEditingPersonnel = false;

  void updatePersonnel(BuildContext context) async {
    try {
      setState(() {
        _isEditingPersonnel = true;
      });
      await _firestore
          .collection("personnels")
          .doc(widget.personnel.id)
          .update({
        "name": _nameController.text.trim(),
        "role": _roleController.text.trim(),
        "phoneNumber": _phoneNumberController.text.trim(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Personnel successfully updated!!!')));
      Navigator.pop(context);
      setState(() {
        _isEditingPersonnel = false;
      });
    } catch (e) {
      setState(() {
        _isEditingPersonnel = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong...')));
    }
  }

  @override
  void initState() {
    _nameController.text = widget.personnel.name;
    _roleController.text = widget.personnel.role;
    _phoneNumberController.text = widget.personnel.phoneNumber;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              text: 'Update Personnel',
              action: () {
                updatePersonnel(context);
              },
              isLoading: _isEditingPersonnel,
            )
          ],
        ),
      ),
    );
  }
}
