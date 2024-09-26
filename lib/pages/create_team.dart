import 'package:flutter/material.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/widgets/custom_textfield.dart';

class CreateTeam extends StatelessWidget {
  const CreateTeam({super.key});

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
            const CustomFormField(
              title: "Team Name",
              form: CustomTextField(),
            ),
            const SizedBox(
              height: 16,
            ),
            const CustomFormField(
              title: "Team Description",
              form: CustomTextField(
                maxLines: 4,
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
