import 'package:flutter/material.dart';
import 'package:task_management/widgets/custom_textfield.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: Column(
        children: [
          const FormField(title: 'Task Title', form: CustomTextField()),
          const Row(
            children: [
              FormField(
                  title: 'Start Time',
                  form: CustomTextField(
                    type: TextInputType.datetime,
                  )),
              FormField(
                  title: 'End Time',
                  form: CustomTextField(type: TextInputType.datetime)),
            ],
          ),
          const FormField(
              title: 'Start Date',
              form: CustomTextField(type: TextInputType.datetime)),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: const Text('Create'),
          )
        ],
      ),
    );
  }
}

class FormField extends StatelessWidget {
  const FormField({super.key, required this.title, required this.form});
  final String title;
  final Widget form;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        form,
      ],
    );
  }
}
