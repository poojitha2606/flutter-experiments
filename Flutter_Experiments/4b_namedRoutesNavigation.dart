import 'package:flutter/material.dart'; 
 
void main() => runApp(MyApp()); 
 
class MyApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'Named Routes Demo', 
      initialRoute: '/', 
      routes: { 
        '/': (context) => FirstScreen(), 
        '/second': (context) => SecondScreen(), 
      }, 
    ); 
  } 
} 
 
class FirstScreen extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    final routeName = ModalRoute.of(context)?.settings.name ?? '/'; 
 
    return Scaffold( 
      appBar: AppBar(title: Text('First Screen')), 
      body: Center( 
        child: Column( 
          mainAxisSize: MainAxisSize.min, 
          children: [ 
            Text( 
              'Current Route: $routeName', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), 
            ), 
            SizedBox(height: 20), 
            ElevatedButton( 
              onPressed: () { 
                Navigator.pushNamed(context, '/second'); 
              }, 
              child: Text('Go to Second Screen'), 
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
} 
 
class SecondScreen extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    final routeName = ModalRoute.of(context)?.settings.name ?? '/second'; 
 
    return Scaffold( 
      appBar: AppBar(title: Text('Second Screen')), 
      body: Center( 
        child: Column( 
          mainAxisSize: MainAxisSize.min, 
          children: [ 
            Text( 
              'Current Route: $routeName', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), 
            ), 
            SizedBox(height: 20), 
            ElevatedButton( 
              onPressed: () { 
                Navigator.pop(context); 
              }, 
              child: Text('Go Back'), 
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
} 
 
 
