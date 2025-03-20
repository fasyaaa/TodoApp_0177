import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class Statefull extends StatefulWidget {
  const Statefull({super.key});

  @override
  State<Statefull> createState() => _StatefullState();
}

class _StatefullState extends State<Statefull> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _taskcontroller = TextEditingController();

  DateTime? _selectedDate;

  List<Task> listTask = [];

  void addData() {
    if (_key.currentState!.validate() && _selectedDate != null) {
      setState(() {
        listTask.add(
          Task(
            name: _taskcontroller.text,
            deadline: _selectedDate!,
            isDone: false,
          ),
        );
        _taskcontroller.clear();
        _selectedDate = null;
      });
    }
  }

  void toggleTaskStatus(int index) {
    setState(() {
      listTask[index].isDone = !listTask[index].isDone;
    });
  }

  void _showDatePicker() {
    DateTime now = DateTime.now();
    DateTime tempDate = _selectedDate ?? now;

    if (tempDate.isAfter(now)) {
      tempDate =
          now; 
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: tempDate,
                  minimumDate: DateTime(2000),
                  maximumDate: now,
                  use24hFormat: false,
                  onDateTimeChanged: (DateTime value) {
                    setState(() {
                      _selectedDate = value.isAfter(now) ? now : value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedDate = tempDate;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Input"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date configuration
                      Row(
                        children: [
                          const Text(
                            'Task Date :',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            onPressed: _showDatePicker,
                            icon: const Icon(Icons.date_range),
                          ),
                        ],
                      ),

                      Text(
                        _selectedDate == null
                            ? "Selected a date"
                            : DateFormat(
                              'EEE, MMM d yyyy | HH:MM a',
                            ).format(_selectedDate!),
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
              Form(
                key: _key,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _taskcontroller,
                        decoration: InputDecoration(
                          labelText: "First Name",
                          hintText: "Enter Your First Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          return (value!.isEmpty) //Ternary function
                              ? 'Form tidak boleh kosong'
                              : null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    SizedBox(width: 16),
                    FilledButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          addData();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Task Added Successfully"),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0xff7973d1),
                      ), //setting for hex color
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // List Tasks
              Text(
                'List Task',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: listTask.length,
                  itemBuilder: (context, index) {
                    Task task = listTask[index];
                    return Card(
                      color: Colors.grey[200],
                      child: ListTile(
                        title: Text(
                          task.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deadline : ${DateFormat('dd-MM-yyyy HH:mm').format(task.deadline)}",
                              style: const TextStyle(color: Colors.blueGrey),
                            ),
                            Text(
                              task.isDone ? "Done" : "Not Done",
                              style: TextStyle(
                                color: task.isDone ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        trailing: Checkbox(
                          value: task.isDone,
                          onChanged: (value) => toggleTaskStatus(index),
                          activeColor: Colors.green,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Task {
  String name;
  DateTime deadline;
  bool isDone;

  Task({required this.name, required this.deadline, required this.isDone});
}
