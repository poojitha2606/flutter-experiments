import 'package:flutter/material.dart'; 
void main() => runApp(MyApp()); 
// Root app 
class MyApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      home: Scaffold( 
        appBar: AppBar(title: Text("Profile App")), 
        body: Center( 
          child: Column( 
            mainAxisSize: MainAxisSize.min, 
            children: [ 
              ProfileCard( 
                name: "John Doe", 
                email: "john.doe@example.com", 
              ), 
              SizedBox(height: 20), 
              ActionButton( 
                text: "Follow", 
                color: Colors.green, 
                onPressed: () { 
                  // Example action 
                  print("Follow button clicked"); 
                }, 
              ), 
            ], 
          ), 
        ), 
      ), 
    ); 
  } 
} 
 
// Custom Profile Card Widget 
class ProfileCard extends StatelessWidget { 
  final String name; 
  final String email; 
 
  ProfileCard({required this.name, required this.email}); 
 
  @override 
  Widget build(BuildContext context) { 
    return Card( 
      elevation: 4, 
      margin: EdgeInsets.all(12), 
      child: ListTile( 
        leading: CircleAvatar( 
          backgroundColor: Colors.blue, 
          child: Icon(Icons.person, color: Colors.white), 
        ), 
        title: Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), 
        subtitle: Text(email), 
      ), 
    ); 
  } 
} 
 
// Custom Action Button Widget 
class ActionButton extends StatelessWidget { 
  final String text; 
  final Color color; 
  final VoidCallback onPressed; 
 
  ActionButton({required this.text, required this.color, required this.onPressed}); 
 
  @override 
  Widget build(BuildContext context) { 
    return ElevatedButton( 
      style: ElevatedButton.styleFrom(backgroundColor: color), 
      onPressed: onPressed, 
      child: Text(text), 
    ); 
  } 
}