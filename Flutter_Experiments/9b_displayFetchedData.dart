import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http; 
import 'dart:convert'; 
 
void main() => runApp(MyApp()); 
 
class MyApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      debugShowCheckedModeBanner: false, 
      title: 'REST API Demo', 
      theme: ThemeData(primarySwatch: Colors.blue), 
      home: PostsPage(), 
    ); 
  } 
} 
 
class PostsPage extends StatelessWidget { 
  // Function to fetch list of posts 
  Future<List<dynamic>> fetchPosts() async { 
    final response = 
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts")); 
 
    if (response.statusCode == 200) { 
      return json.decode(response.body); // returns List of posts 
    } else { 
      throw Exception("Failed to load posts"); 
    } 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text("Posts from API")), 
      body: FutureBuilder<List<dynamic>>( 
        future: fetchPosts(), 
        builder: (context, snapshot) { 
          if (snapshot.connectionState == ConnectionState.waiting) { 
            return Center(child: CircularProgressIndicator()); // Loading 
          } else if (snapshot.hasError) { 
            return Center(child: Text("Error: ${snapshot.error}")); // Error 
          } else if (snapshot.hasData) { 
            final posts = snapshot.data!; 
            // Display posts in a ListView 
            return ListView.builder( 
              itemCount: posts.length, 
              itemBuilder: (context, index) { 
                final post = posts[index]; 
                return Card( 
                  margin: EdgeInsets.all(10), 
                  child: ListTile( 
                    title: Text( 
                      post['title'], 
                      style: TextStyle( 
                          fontWeight: FontWeight.bold, fontSize: 16), 
                    ), 
                    subtitle: Text(post['body']), 
                  ), 
                ); 
              }, 
            ); 
          } else { 
            return Center(child: Text("No data found")); 
          } 
        }, 
      ), 
    ); 
  } 
}