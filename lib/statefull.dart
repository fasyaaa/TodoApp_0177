import 'package:flutter/material.dart';

class Statefull extends StatefulWidget {
  const Statefull({super.key});

  @override
  State<Statefull> createState() => _StatefullState();
}

class _StatefullState extends State<Statefull> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _taskcontroller = TextEditingController();

  List<String> listTask = [];

  void addData() {
    setState(() {
      listTask.add(_taskcontroller.text);
      _taskcontroller.clear();
    });
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
                      child: Text('Submit'),
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
