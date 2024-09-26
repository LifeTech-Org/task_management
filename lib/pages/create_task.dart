import 'package:flutter/material.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/widgets/custom_textfield.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const CustomFormField(title: 'Task Title', form: CustomTextField()),
            const SizedBox(
              height: 16,
            ),
            const Row(
              children: [
                Expanded(
                  child: CustomFormField(
                    title: 'Start Time',
                    form: CustomTextField(
                      type: TextInputType.datetime,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: CustomFormField(
                    title: 'End Time',
                    form: CustomTextField(type: TextInputType.datetime),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const CustomFormField(
                title: 'Start Date',
                form: CustomTextField(type: TextInputType.datetime)),
            const SizedBox(
              height: 36,
            ),
            CustomButton(text: 'Create', action: () {})
          ],
        ),
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({super.key, required this.title, required this.form});
  final String title;
  final Widget form;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        form,
      ],
    );
  }
}
