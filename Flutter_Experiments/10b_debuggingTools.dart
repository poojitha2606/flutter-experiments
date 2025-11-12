import 'package:flutter/material.dart'; 
 
void main() { 
  runApp(MyApp()); 
} 
 
class MyApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'Flutter Debug Demo', 
      home: Scaffold( 
        appBar: AppBar(title: Text('Flutter Debug Demo')), 
        body: DebugDemoWidget(), 
      ), 
    ); 
  } 
} 
 
// Demo widget with intentional issue: counter can go negative 
class DebugDemoWidget extends StatefulWidget { 
  @override 
  _DebugDemoWidgetState createState() => _DebugDemoWidgetState(); 
} 
 
class _DebugDemoWidgetState extends State<DebugDemoWidget> { 
  int _counter = 0; 
 
  void _increment() { 
    setState(() { 
      _counter++; 
      debugPrint('Counter incremented: $_counter'); // Debug print 
    }); 
  } 
 
  void _decrement() { 
    setState(() { 
      _counter--; 
      debugPrint('Counter decremented: $_counter'); 
      assert(_counter >= 0, 'Counter should not be negative!'); // Assertion for bug 
    }); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Center( 
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [ 
          Text('Counter: $_counter', style: TextStyle(fontSize: 28)), 
          SizedBox(height: 10), 
          Row( 
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [ 
              ElevatedButton(onPressed: _increment, child: Text('Increment')), 
              SizedBox(width: 10), 
              ElevatedButton(onPressed: _decrement, child: Text('Decrement')), 
            ], 
          ), 
        ], 
      ), 
    ); 
  } 
} 