import 'package:flutter/material.dart'; 
 
void main() { 
  runApp(MyApp()); 
} 
 
class MyApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      debugShowCheckedModeBanner: false, 
      title: 'Animation Demo', 
      theme: ThemeData(primarySwatch: Colors.blue), 
      home: AnimationPage(), 
    ); 
  } 
} 
 
class AnimationPage extends StatefulWidget { 
  @override 
  _AnimationPageState createState() => _AnimationPageState(); 
} 
 
class _AnimationPageState extends State<AnimationPage> { 
  bool _big = false; 
  bool _visible = true; 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text("Flutter Animations")), 
      body: Center( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [ 
            GestureDetector( 
              onTap: () { 
                setState(() { 
                  _big = !_big; 
                }); 
              }, 
              child: AnimatedContainer( 
                duration: Duration(seconds: 1), 
                width: _big ? 200 : 100, 
                height: _big ? 200 : 100, 
                color: _big ? Colors.blue : Colors.red, 
                child: Center( 
                  child: Text("Tap Me", 
                      style: TextStyle(color: Colors.white, fontSize: 16)), 
                ), 
              ), 
            ), 
            SizedBox(height: 30), 
            ElevatedButton( 
              onPressed: () { 
                setState(() { 
                  _visible = !_visible; 
                }); 
              }, 
              child: Text("Toggle Text"), 
            ), 
            AnimatedOpacity( 
              opacity: _visible ? 1.0 : 0.0, 
              duration: Duration(seconds: 1), 
              child: Text("Hello Flutter!", 
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), 
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
} 