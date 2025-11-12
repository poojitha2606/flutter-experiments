import 'package:flutter/material.dart'; 
void main() => runApp(MyApp()); 
// Root App 
class MyApp extends StatelessWidget { 
@override 
Widget build(BuildContext context) { 
return MaterialApp( 
home: Scaffold( 
backgroundColor: Colors.grey[200], 
appBar: AppBar(title: Text("Stateless vs Stateful")), 
body: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [ 
            MyStatelessWidget(), 
            SizedBox(height: 30), 
            MyStatefulWidget(), 
          ], 
        ), 
      ), 
    ); 
  } 
} 
 
// Stateless Widget 
class MyStatelessWidget extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return Card( 
      color: Colors.orange[200], 
      margin: EdgeInsets.all(12), 
      child: Padding( 
        padding: const EdgeInsets.all(16.0), 
        child: Text( 
          "I am Stateless     ", 
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), 
        ), 
      ), 
    ); 
  } 
} 
 
// Stateful Widget 
class MyStatefulWidget extends StatefulWidget { 
  @override 
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState(); 
} 
 
class _MyStatefulWidgetState extends State<MyStatefulWidget> { 
  int counter = 0; 
 
  @override 
  Widget build(BuildContext context) { 
    return Card( 
      color: Colors.lightBlue[100], 
      margin: EdgeInsets.all(12), 
      child: Padding( 
        padding: const EdgeInsets.all(16.0), 
        child: Column( 
          children: [ 
            Text("I am Stateful      \nCounter: $counter", 
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center), 
            SizedBox(height: 10), 
            ElevatedButton( 
              style: ElevatedButton.styleFrom( 
                backgroundColor: Colors.blue, 
                foregroundColor: Colors.white, 
              ), 
onPressed: () => setState(() => counter++), 
child: Text("Add Count"), 
), 
], 
), 
), 
); 
} 
}