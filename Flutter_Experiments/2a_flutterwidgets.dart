import 'package:flutter/material.dart'; 
void main() { 
runApp(MyApp()); 
} 
class MyApp extends StatelessWidget { 
// Using a reliable Flutter logo from a trusted source 
final String imageUrl = 
'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png'; 
@override 
Widget build(BuildContext context) { 
return MaterialApp( 
title: 'Flutter Widgets Demo', 
home: Scaffold( 
appBar: AppBar( 
title: Text('Flutter Widgets Demo'), 
        ), 
        body: Center( 
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [ 
 
              //           TEXT WIDGET 
              Text( 
                '    Welcome to Flutter!', 
                style: TextStyle( 
                  fontSize: 24, 
                  color: Colors.deepPurple, 
                  fontWeight: FontWeight.bold, 
                ), 
              ), 
 
              SizedBox(height: 20), 
 
              //                 IMAGE WIDGET with error handling 
              Image.network( 
                imageUrl, 
                width: 200, 
                errorBuilder: (context, error, stackTrace) { 
                  return Column( 
                    children: [ 
                      Icon(Icons.error, color: Colors.red, size: 40), 
                      Text('Failed to load image'), 
                    ], 
                  ); 
                }, 
              ), 
 
              SizedBox(height: 20), 
 
              //           CONTAINER WIDGET 
              Container( 
                padding: EdgeInsets.all(16), 
                decoration: BoxDecoration( 
                  color: Colors.amber[200], 
                  borderRadius: BorderRadius.circular(8), 
                ), 
                child: Text( 
                  'This is a container with padding and background color.', 
                  textAlign: TextAlign.center, 
                ), 
              ), 
 
              SizedBox(height: 20), 
 
              //       ICON WIDGETS IN A ROW 
              Row( 
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [ 
                  Icon(Icons.favorite, color: Colors.red, size: 30), 
                  SizedBox(width: 10), 
                  Icon(Icons.star, color: Colors.orange, size: 30), 
                  SizedBox(width: 10), 
                  Icon(Icons.thumb_up, color: Colors.blue, size: 30), 
                ], 
              ), 
            ], 
          ), 
        ), 
      ), 
    ); 
  } 
} 