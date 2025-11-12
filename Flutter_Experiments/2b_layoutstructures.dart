import 'package:flutter/material.dart'; 
 
void main() => runApp(LayoutDemoApp()); 
 
class LayoutDemoApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'Layout Widgets Demo', 
      home: Scaffold( 
        appBar: AppBar( 
          title: Text('Row, Column & Stack Demo'), 
          centerTitle: true, 
        ), 
        body: ListView( 
          padding: EdgeInsets.all(16), 
          children: [ 
 
            // Column Layout 
            Text('    Column Layout', style: headerStyle), 
            Container( 
              color: Colors.blue[50], 
              padding: EdgeInsets.all(12), 
              child: Column( 
                crossAxisAlignment: CrossAxisAlignment.stretch, 
                children: [ 
                  coloredBox('Box 1', Colors.red), 
                  coloredBox('Box 2', Colors.green), 
                  coloredBox('Box 3', Colors.orange), 
                ], 
              ), 
            ), 
 
            SizedBox(height: 20), 
 
            // Row Layout 
            Text('    Row Layout', style: headerStyle), 
            Container( 
              color: Colors.green[50], 
              padding: EdgeInsets.all(12), 
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                children: [ 
                  Flexible(child: coloredBox('Box A', Colors.purple)), 
                  Flexible(child: coloredBox('Box B', Colors.teal)), 
                  Flexible(child: coloredBox('Box C', Colors.indigo)), 
                ], 
              ), 
            ), 
 
            SizedBox(height: 20), 
 
            // Stack Layout 
            Text('      Stack Layout', style: headerStyle), 
            Container( 
              width: double.infinity, 
              height: 200, 
              color: Colors.grey[300], 
              child: Stack( 
                alignment: Alignment.center, 
                children: [ 
                  Container(width: 180, height: 180, color: Colors.yellow), 
                  Container(width: 120, height: 120, color: Colors.blue), 
                  Container(width: 60, height: 60, color: Colors.red), 
                  Text('Stacked!', style: TextStyle(color: Colors.white)), 
                ], 
              ), 
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
 
  // Helper method to create colored boxes with text 
  Widget coloredBox(String label, Color color) { 
    return Container( 
      margin: EdgeInsets.all(4), 
      padding: EdgeInsets.all(16), 
      color: color, 
      child: Center( 
        child: Text( 
          label, 
          style: TextStyle(color: Colors.white), 
        ), 
      ), 
    ); 
  } 
 
  // Style for section headers 
  TextStyle get headerStyle => TextStyle( 
        fontSize: 18, 
        fontWeight: FontWeight.bold, 
        color: Colors.black87, 
      ); 
} 