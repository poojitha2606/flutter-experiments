import 'package:flutter/material.dart'; 
void main() => runApp(MediaQueryExampleApp()); 
class MediaQueryExampleApp extends StatelessWidget { 
@override 
Widget build(BuildContext context) { 
return MaterialApp( 
title: 'MediaQuery & Breakpoints Demo', 
home: Scaffold( 
appBar: AppBar(title: Text('Responsive UI with MediaQuery')), 
body: ResponsiveWidget(), 
), 
); 
} 
} 
 
class ResponsiveWidget extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    // Get screen width from MediaQuery 
    double screenWidth = MediaQuery.of(context).size.width; 
 
    // Define breakpoints 
    if (screenWidth < 600) { 
      return mobileLayout(); 
    } else if (screenWidth < 900) { 
      return tabletLayout(); 
    } else { 
      return desktopLayout(); 
    } 
  } 
 
  Widget mobileLayout() { 
    return Center( 
      child: Container( 
        color: Colors.blue, 
        width: 150, 
        height: 150, 
        child: Center( 
          child: Text('Mobile Layout', 
              style: TextStyle(color: Colors.white, fontSize: 18)), 
        ), 
      ), 
    ); 
  } 
 
  Widget tabletLayout() { 
    return Center( 
      child: Container( 
        color: Colors.green, 
        width: 300, 
        height: 300, 
        child: Center( 
          child: Text('Tablet Layout', 
              style: TextStyle(color: Colors.white, fontSize: 24)), 
        ), 
      ), 
    ); 
  } 
 
  Widget desktopLayout() { 
    return Center( 
      child: Container( 
        color: Colors.orange, 
        width: 450, 
        height: 450, 
        child: Center( 
          child: Text('Desktop Layout', 
              style: TextStyle(color: Colors.white, fontSize: 30)), 
        ), 
      ), 
    ); 
  } 
} 