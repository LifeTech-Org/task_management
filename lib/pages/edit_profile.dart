import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/models/user.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Future<UserData> fetchUser() async {
    final res =
        await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    return UserData.fromJson({...res.data()!, "id": res.id});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: fetchUser(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return EditWidget(
              user: snapshot.data!,
            );
          }),
    );
  }
}

class EditWidget extends StatefulWidget {
  const EditWidget({super.key, required this.user});
  final UserData user;
  @override
  State<EditWidget> createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    _nameController.text = widget.user.name;
    _phoneController.text = widget.user.phoneNumber ?? "";
    _countryController.text = widget.user.country ?? '';
    _cityController.text = widget.user.city ?? '';
    super.initState();
  }

  bool _isUpdatingProfile = false;

  final picker = ImagePicker();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void updateProfile(BuildContext context) async {
    try {
      setState(() {
        _isUpdatingProfile = true;
      });
// Upload the picture and get a url

      await _firestore.collection("users").doc(widget.user.id).update({
        "name": _nameController.text.trim(),
        "phoneNumber": _phoneController.text.trim(),
        "country": _countryController.text.trim(),
        "city": _cityController.text.trim(),
        "photoUrl": ""
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile successfully updated!!!')));
      setState(() {
        _isUpdatingProfile = false;
      });
    } catch (e) {
      setState(() {
        _isUpdatingProfile = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong...')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: _pickImage,
              child: _image == null
                  ? Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                    )
                  : Stack(
                      children: [
                        CircleAvatar(
                          foregroundImage: FileImage(_image!),
                          radius: 50,
                        ),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(
              height: 12,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    _image = null;
                  });
                },
                child: Text(
                  'Remove Picture',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )),
            const SizedBox(
              height: 24,
            ),
            CustomFormField(
              title: 'Name',
              form: CustomTextField(
                controller: _nameController,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomFormField(
              title: 'Phone Number',
              form: CustomTextField(
                controller: _phoneController,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomFormField(
              title: 'Country',
              form: CustomTextField(
                controller: _countryController,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomFormField(
              title: 'City',
              form: CustomTextField(
                controller: _cityController,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomButton(
              text: 'Save Changes',
              action: () {
                updateProfile(context);
              },
              isLoading: _isUpdatingProfile,
            )
          ],
        ),
      ),
    );
  }
}
