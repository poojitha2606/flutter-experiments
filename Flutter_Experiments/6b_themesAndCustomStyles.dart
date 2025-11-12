import 'package:flutter/material.dart'; 
 
void main() => runApp(MyApp()); 
 
class MyApp extends StatefulWidget { 
  @override 
  State<MyApp> createState() => _MyAppState(); 
} 
 
class _MyAppState extends State<MyApp> { 
  bool isDark = false; 
 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      theme: ThemeData( 
        brightness: Brightness.light, 
        primarySwatch: Colors.blue, 
      ), 
      darkTheme: ThemeData( 
        brightness: Brightness.dark, 
        primarySwatch: Colors.deepPurple, 
      ), 
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light, 
      home: Scaffold( 
        appBar: AppBar(title: Text("Theme Demo")), 
        body: Center( 
          child: Column( 
            mainAxisSize: MainAxisSize.min, 
            children: [ 
              Text("Hello Flutter!", style: Theme.of(context).textTheme.titleLarge), 
              SizedBox(height: 20), 
              ElevatedButton( 
                onPressed: () => setState(() => isDark = !isDark), 
                child: Text(isDark ? "Switch to Light" : "Switch to Dark"), 
              ), 
            ], 
          ), 
        ), 
      ), 
    ); 
  } 
}