import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Form',
      home: StudentForm(),
    );
  }
}

class StudentForm extends StatefulWidget {
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _rollNo = '';
  String _gender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Details Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name field
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value ?? '',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              // Roll No field
              TextFormField(
                decoration: InputDecoration(labelText: 'Roll No'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _rollNo = value ?? '',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your roll number' : null,
              ),

              SizedBox(height: 20),
              // Gender selection
              Text('Gender:', style: TextStyle(fontSize: 16)),
              // The 'groupValue' property for RadioListTile is deprecated in very recent
              // pre-release Flutter versions (e.g., after v3.32.0-0.0.pre).
              // The suggested fix is to use a 'RadioGroup' ancestor.
              // The RadioGroup manages the selected value and its changes for
              // all RadioListTile children, allowing them to omit their
              // individual groupValue and onChanged properties.
              RadioGroup<String>(
                groupValue: _gender, // FIX: Changed 'value' to 'groupValue'
                onChanged: (String? newValue) {
                  setState(() {
                    _gender = newValue!;
                  });
                },
                // FIX: Changed 'children' to 'child' and wrapped the list in a Column
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('Male'),
                      value: 'Male',
                      // groupValue and onChanged are now managed by the RadioGroup ancestor
                    ),
                    RadioListTile<String>(
                      title: Text('Female'),
                      value: 'Female',
                      // groupValue and onChanged are now managed by the RadioGroup ancestor
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Submitted Info'),
                        content: Text(
                          'Name: $_name\nRoll No: $_rollNo\nGender: $_gender',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          )
                        ],
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}