import 'package:flutter/material.dart'; 
void main() { 
  runApp(MyApp()); 
} 
class MyApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'Form Validation Demo', 
      home: FormValidationPage(), 
    ); 
  } 
} 
class FormValidationPage extends StatefulWidget { 
  @override 
  _FormValidationPageState createState() => _FormValidationPageState(); 
} 
 
class _FormValidationPageState extends State<FormValidationPage> { 
  final _formKey = GlobalKey<FormState>(); 
  final _nameController = TextEditingController(); 
  final _emailController = TextEditingController(); 
  String? _validateName(String? value) { 
    if (value == null || value.isEmpty) { 
      return 'Name is required'; 
    } 
    return null; 
  } 
  String? _validateEmail(String? value) { 
    if (value == null || value.isEmpty) { 
      return 'Email is required'; 
    } 
    // Basic email regex 
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+'); 
    if (!emailRegex.hasMatch(value)) { 
      return 'Enter a valid email'; 
    } 
    return null; 
  } 
 
  void _submitForm() { 
    if (_formKey.currentState!.validate()) { 
      // If the form is valid, show a snackbar 
      ScaffoldMessenger.of(context).showSnackBar( 
        SnackBar(content: Text('Form submitted successfully!')), 
      ); 
    } 
  } 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text('Form Validation')), 
      body: Padding( 
        padding: const EdgeInsets.all(16.0), 
        child: Form( 
          key: _formKey, 
          child: Column( 
            children: [ 
              // Name Field 
              TextFormField( 
                controller: _nameController, 
                decoration: InputDecoration(labelText: 'Name'), 
                validator: _validateName, 
              ), 
              SizedBox(height: 16), 
 
              // Email Field 
              TextFormField( 
                controller: _emailController, 
                decoration: InputDecoration(labelText: 'Email'), 
                validator: _validateEmail, 
              ), 
              SizedBox(height: 32), 
 
              // Submit Button 
              ElevatedButton( 
                onPressed: _submitForm, 
                child: Text('Submit'), 
              ), 
            ], 
          ), 
        ), 
      ), 
    ); 
  } 
} 
