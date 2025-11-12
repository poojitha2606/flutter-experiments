import 'package:flutter/material.dart'; 

void main() => runApp(NavigationWithImagesApp()); 

class NavigationWithImagesApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'Navigator with Images Demo', 
      home: FirstScreen(), 
    ); 
  } 
} 

// First screen with image and button 
class FirstScreen extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text('First Screen')), 
      body: Center( 
        child: Column( 
          mainAxisSize: MainAxisSize.min, 
          children: [ 
            // The previous image URL was returning a 404 error. 
            // Replaced with a working placeholder image from picsum.photos. 
            Image.network( 
              'https://picsum.photos/id/1018/600/400', // Replaced problematic URL
              width: 300, 
              height: 200, 
              fit: BoxFit.cover, 
            ), 
            SizedBox(height: 20), 
            ElevatedButton( 
              child: Text('Go to Second Screen'), 
              onPressed: () { 
                Navigator.push( 
                  context, 
                  MaterialPageRoute(builder: (context) => SecondScreen()), 
                ); 
              }, 
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
} 

// Second screen with different image and button 
class SecondScreen extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text('Second Screen')), 
      body: Center( 
        child: Column( 
          mainAxisSize: MainAxisSize.min, 
          children: [ 
            // This image URL was not reported as problematic.
            // Using another working placeholder image from picsum.photos for consistency. 
            Image.network( 
              'https://picsum.photos/id/1015/600/400', // Replaced for consistency, original was likely working
              width: 300, 
              height: 200, 
              fit: BoxFit.cover, 
            ), 
            SizedBox(height: 20), 
            ElevatedButton( 
              child: Text('Go Back'), 
              onPressed: () { 
                Navigator.pop(context); 
              }, 
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
}