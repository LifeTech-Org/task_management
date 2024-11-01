import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/models/personnel.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/pages/auth/signin.dart';
import 'package:task_management/pages/create_task.dart';
import 'package:task_management/pages/manage_tasks.dart';
import 'package:task_management/widgets/custom_textfield.dart';

class EditTask extends StatelessWidget {
  EditTask({super.key, required this.id});
  final String id;
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController _titleController = TextEditingController();

  Future<Task> fetchTask() async {
    final task = await _firestore.collection("tasks").doc(id).get();
    return Task.fromJson({...task.data()!, "id": id});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
      ),
      body: FutureBuilder(
          future: fetchTask(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return EditTaskWidget(task: snapshot.data!);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class EditTaskWidget extends StatefulWidget {
  const EditTaskWidget({super.key, required this.task});
  final Task task;
  @override
  State<EditTaskWidget> createState() => _EditTaskWidgetState();
}

class _EditTaskWidgetState extends State<EditTaskWidget> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final TextEditingController _titleController = TextEditingController();

  TimeOfDay? start;
  TimeOfDay? end;
  DateTime? date;

  List<String> _selectedPersonnelsId = [];

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

  @override
  void initState() {
    _titleController.text = widget.task.title;
    _selectedPersonnelsId = widget.task.personnelsId;
    start = TimeOfDay(
        hour: widget.task.start.hour, minute: widget.task.start.minute);
    end = TimeOfDay(hour: widget.task.end.hour, minute: widget.task.end.minute);
    date = widget.task.date;
    super.initState();
  }

  bool isUpdating = false;

  void updateTask(BuildContext context) async {
    try {
      setState(() {
        isUpdating = true;
      });
      await _firestore.collection("tasks").doc(widget.task.id).update({
        "title": _titleController.text.trim(),
        "date": date,
        "start": DateTime(
            date!.year, date!.month, date!.day, start!.hour, start!.minute),
        "end": DateTime(
            date!.year, date!.month, date!.day, end!.hour, end!.minute),
        "personnelsId": _selectedPersonnelsId,
        "isMarkedDone": false,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task successfully updated!!!')));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ManageTask(),
        ),
      );
      setState(() {
        isUpdating = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong...')));
      setState(() {
        isUpdating = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            end == null ? 'Choose Time' : end!.format(context),
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
                      date == null ? 'DD/MM/YYYY' : formatDate(date!),
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
              form: FutureBuilder(
                  future: fetchPersonnels(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
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
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
              text: 'Update Task',
              action: () {
                updateTask(context);
              },
              isLoading: isUpdating,
            )
          ],
        ),
      ),
    );
    ;
  }
}
