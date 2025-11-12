import 'package:flutter/material.dart'; 
void main() => runApp(MyApp()); 
class MyApp extends StatelessWidget { 
@override 
Widget build(BuildContext context) { 
return MaterialApp( 
title: 'Multiple Animations', 
      home: AnimationExample(), 
    ); 
  } 
} 
class AnimationExample extends StatefulWidget { 
  @override 
  _AnimationExampleState createState() => _AnimationExampleState(); 
} 
class _AnimationExampleState extends State<AnimationExample> { 
  bool _visible = true; 
  bool _moved = false; 
  bool _scaled = false; 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text('Fade, Slide & Scale Animations')), 
      body: Stack( 
        children: [ 
          // Slide Animation 
          AnimatedPositioned( 
            duration: Duration(seconds: 1), 
            curve: Curves.easeInOut, 
            top: _moved ? 300 : 100, 
            left: 100, 
            child: AnimatedOpacity( 
              duration: Duration(seconds: 1), 
              opacity: _visible ? 1.0 : 0.0, 
              child: AnimatedContainer( 
                duration: Duration(seconds: 1), 
                width: _scaled ? 150 : 100, 
                height: _scaled ? 150 : 100, 
                color: Colors.teal, 
                child: Center( 
                  child: Text( 
                    'Animate Me', 
                    style: TextStyle(color: Colors.white), 
                    textAlign: TextAlign.center, 
                  ), 
                ), 
              ), 
            ), 
          ), 
        ], 
      ), 
      floatingActionButton: FloatingActionButton( 
        child: Icon(Icons.play_arrow), 
        onPressed: () { 
          setState(() { 
            _visible = !_visible;  // Fade 
            _moved = !_moved;      // Slide 
            _scaled = !_scaled;    // Scale 
          }); 
        }, 
      ), 
    ); 
  } 
} 