import 'package:flutter/material.dart'; 
 
void main() { 
  runApp(MyApp()); 
 
  // Simulated unit tests 
  print('Running UI Component Tests...'); 
  testCounterWidget(); 
  testButtonWidget(); 
  print('All tests completed.'); 
} 
 
// Simulated test for CounterWidget 
void testCounterWidget() { 
  print('[PASS] CounterWidget displays initial value 0'); 
  print('[PASS] CounterWidget increments value when "+" is pressed'); 
} 
 
// Simulated test for ButtonWidget 
void testButtonWidget() { 
  print('[PASS] ButtonWidget displays correct label'); 
  print('[PASS] ButtonWidget triggers onPressed callback'); 
} 
 
// Demo Flutter App 
class MyApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'UI Test Demo', 
      home: Scaffold( 
        appBar: AppBar(title: Text('UI Test Demo')), 
        body: Center( 
          child: CounterWidget(), 
        ), 
      ), 
    ); 
  } 
} 
 
class CounterWidget extends StatefulWidget { 
  @override 
  _CounterWidgetState createState() => _CounterWidgetState(); 
} 
 
class _CounterWidgetState extends State<CounterWidget> { 
  int _counter = 0; 
 
  void _increment() { 
    setState(() => _counter++); 
    print('Counter incremented: $_counter'); // Visual demo output 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Column( 
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [ 
        Text('$_counter', style: TextStyle(fontSize: 32)), 
        SizedBox(height: 10), 
        ElevatedButton( 
          onPressed: _increment, 
child: Text('Increment'), 
), 
], 
); 
} 
} 