import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    setState(() {
      listTask.add(_taskcontroller.text);
      _taskcontroller.clear();
    });
  }

  void _showDatePicker() {
    DateTime tempDate = _selectedDate ?? DateTime.now();

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
              const Text(
                'Selected Task Date',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ScrollDatePicker(
                  selectedDate: tempDate,
                  locale: const Locale('en'),
                  onDateTimeChanged: (DateTime value) {
                    setState(() {
                      tempDate = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _selectedDate = tempDate;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Submit', style: TextStyle(color: Colors.white),),
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

                      Text(_selectedDate == null ? "Selected a date" : DateFormat('EEE, MMM d, yyyy').format(_selectedDate!), 
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
            ],
          ),
        ),
      ),
    );
  }
}
