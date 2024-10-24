import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management/models/personnel.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/widgets/custom_textfield.dart';

class CreateTask extends StatefulWidget {
  CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController _titleController = TextEditingController();

  Future<List<Personnel>> fetchPersonnels() async {
    final collection = await _firestore.collection("personnels").get();
    final personnels = collection.docs
        .map((doc) => {...doc.data(), "id": doc.id})
        .map((json) => Personnel.fromJson(json))
        .toList();
    return personnels;
  }

  TimeOfDay? startTime;
  TimeOfDay? endTime;
  DateTime? startDate;

  final List<Personnel> _selectedPersonnels = [];

  Future<DateTime?> selectDate(BuildContext context) async {
    final date = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2028));
    return date;
  }

  Future<TimeOfDay?> selectTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return time;
  }

  bool isCreating = false;

  void createTask(BuildContext context) async {
    try {
      setState(() {
        isCreating = true;
      });
      await _firestore.collection("tasks").add({
        "title": _titleController.text.trim(),
        "startTime": startTime!.format(context),
        "endTime": endTime!.format(context),
        "startDate": startDate,
        "personnels": _selectedPersonnels.map((p) => p.id).toList(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task successfully created!!!')));
      setState(() {
        isCreating = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong...')));
      setState(() {
        isCreating = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Task"),
        ),
        body: FutureBuilder(
            future: fetchPersonnels(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomFormField(
                          title: 'Task Title',
                          form: CustomTextField(
                            controller: _titleController,
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomFormField(
                              title: 'Start Time',
                              form: TextButton(
                                onPressed: () async {
                                  final time = await selectTime(context);
                                  setState(() {
                                    startTime = time;
                                  });
                                },
                                child: Text('Select'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: CustomFormField(
                              title: 'End Time',
                              form: TextButton(
                                  onPressed: () async {
                                    final time = await selectTime(context);
                                    setState(() {
                                      endTime = time;
                                    });
                                  },
                                  child: Text('Select')),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomFormField(
                        title: 'Date',
                        form: TextButton(
                            onPressed: () async {
                              final date = await selectDate(context);
                              setState(() {
                                startDate = date;
                              });
                            },
                            child: Text('Select')),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      CustomFormField(
                        title: 'Select Personnel(s)',
                        form: Column(
                          children: snapshot.data!
                              .map(
                                (personnel) => ListTile(
                                  title: Text(personnel.name),
                                  subtitle: Text(personnel.role),
                                  trailing: Checkbox(
                                      value: _selectedPersonnels
                                          .where((p) => p.id == personnel.id)
                                          .isNotEmpty,
                                      onChanged: (value) {
                                        setState(() {
                                          if (_selectedPersonnels
                                              .where(
                                                  (p) => p.id == personnel.id)
                                              .isNotEmpty) {
                                            _selectedPersonnels.removeWhere(
                                                (p) => p.id == personnel.id);
                                          } else {
                                            _selectedPersonnels.add(personnel);
                                          }
                                        });
                                      }),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                        text: 'Create',
                        action: () {
                          createTask(context);
                        },
                        isLoading: isCreating,
                      )
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
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
