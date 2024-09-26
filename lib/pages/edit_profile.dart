import 'package:flutter/material.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/widgets/custom_textfield.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CustomFormField(
                title: 'Name',
                form: CustomTextField(),
              ),
              const SizedBox(
                height: 16,
              ),
              const CustomFormField(
                title: 'Email',
                form: CustomTextField(
                  type: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const CustomFormField(
                title: 'Password',
                form: CustomTextField(
                  type: TextInputType.visiblePassword,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const CustomFormField(
                title: 'Date of Birth',
                form: CustomTextField(
                  type: TextInputType.datetime,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomFormField(
                title: 'Country/Region',
                form: DropdownButton<String>(
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(child: Text('Nigeria')),
                  ],
                  onChanged: (String? value) {},
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              CustomButton(text: 'Save Changes', action: () {})
            ],
          ),
        ),
      ),
    );
  }
}
