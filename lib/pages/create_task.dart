import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/models/personnel.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/manage_tasks.dart';
import 'package:task_management/widgets/custom_textfield.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});
  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController _titleController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<List<Personnel>> fetchPersonnels() async {
    final collection = await _firestore
        .collection("personnels")
        .where("userId", isEqualTo: _auth.currentUser!.uid)
        .get();
    final personnels = collection.docs
        .map((doc) => {...doc.data(), "id": doc.id})
        .map((json) => Personnel.fromJson(json))
        .toList();
    return personnels;
  }

  TimeOfDay? start;
  TimeOfDay? end;
  DateTime? date;

  final List<String> _selectedPersonnelsId = [];

  Future<DateTime?> selectDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2028));
    return selectedDate;
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
        "date": date,
        "start": DateTime(
            date!.year, date!.month, date!.day, start!.hour, start!.minute),
        "end": DateTime(
            date!.year, date!.month, date!.day, end!.hour, end!.minute),
        "personnelsId": _selectedPersonnelsId,
        "isMarkedDone": false,
        "userId": _auth.currentUser!.uid,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task successfully created!!!')));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ManageTask(),
        ),
      );
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
          title: const Text("Create Task"),
        ),
        body: FutureBuilder(
            future: fetchPersonnels(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
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
                                form: InkWell(
                                  onTap: () async {
                                    final time = await selectTime(context);
                                    setState(() {
                                      start = time;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black54),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        start == null
                                            ? 'Choose Time'
                                            : start!.format(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: CustomFormField(
                                title: 'End Time',
                                form: InkWell(
                                  onTap: () async {
                                    final time = await selectTime(context);
                                    setState(() {
                                      end = time;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black54),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        end == null
                                            ? 'Choose Time'
                                            : end!.format(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomFormField(
                          title: 'Date',
                          form: InkWell(
                            onTap: () async {
                              final selectedDate = await selectDate(context);
                              setState(() {
                                date = selectedDate;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  date == null
                                      ? 'DD/MM/YYYY'
                                      : formatDate(date!),
                                ),
                              ),
                            ),
                          ),
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
                                        value: _selectedPersonnelsId
                                            .contains(personnel.id),
                                        onChanged: (value) {
                                          setState(() {
                                            if (_selectedPersonnelsId
                                                .contains(personnel.id)) {
                                              _selectedPersonnelsId.removeWhere(
                                                  (id) => id == personnel.id);
                                            } else {
                                              _selectedPersonnelsId
                                                  .add(personnel.id);
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
