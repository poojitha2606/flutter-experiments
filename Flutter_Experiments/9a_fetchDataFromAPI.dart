import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REST API Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ApiDemoPage(),
    );
  }
}

class ApiDemoPage extends StatelessWidget {
  // Function to fetch data from Advice API
  Future<String> fetchAdvice() async {
    final response =
        await http.get(Uri.parse("https://api.adviceslip.com/advice"));

    if (response.statusCode == 200) {
      // Convert response JSON into a Dart Map
      final data = json.decode(response.body);
      return data["slip"]["advice"]; // Extract the advice text
    } else {
      throw Exception("Failed to load advice");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fetch Data from REST API")),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchAdvice(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); //        Loading
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  snapshot.data!, // Show fetched advice
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return Text("No data found");
            }
          },
        ),
      ),
    );
  }
} // Added missing closing brace for ApiDemoPage class