import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart'; 
 
void main() { 
  runApp( 
    ChangeNotifierProvider( 
      create: (_) => CartProvider(), 
      child: MyApp(), 
    ), 
  ); 
} 
 
// Root app with 2 tabs 
class MyApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      home: DefaultTabController( 
        length: 2, 
        child: Scaffold( 
          appBar: AppBar( 
            title: Text("Cart Demo"), 
            bottom: TabBar(tabs: [ 
              Tab(text: "setState"), 
              Tab(text: "Provider"), 
            ]), 
          ), 
          body: TabBarView( 
            children: [LocalCart(), GlobalCart()], 
          ), 
        ), 
      ), 
    ); 
  } 
} 
 
///////////////////////////// 
// 1. setState (Local Cart) // 
///////////////////////////// 
class LocalCart extends StatefulWidget { 
  @override 
  _LocalCartState createState() => _LocalCartState(); 
} 
 
class _LocalCartState extends State<LocalCart> { 
  int apples = 0; 
  @override 
  Widget build(BuildContext context) { 
    return Center( 
      child: Column(mainAxisSize: MainAxisSize.min, children: [ 
        Text("Apples: $apples", style: TextStyle(fontSize: 24)), 
        ElevatedButton( 
          onPressed: () => setState(() => apples++), 
          child: Text("Add Apple"), 
        ), 
      ]), 
    ); 
  } 
} 
 
///////////////////////////// 
// 2. Provider (Global Cart) // 
///////////////////////////// 
class CartProvider extends ChangeNotifier { 
  int items = 0; 
  void add() { 
    items++; 
    notifyListeners(); 
  } 
} 
 
class GlobalCart extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    final cart = Provider.of<CartProvider>(context); 
    return Center( 
      child: Column(mainAxisSize: MainAxisSize.min, children: [ 
        Text("Cart Items: ${cart.items}", style: TextStyle(fontSize: 24)), 
        ElevatedButton( 
          onPressed: cart.add, 
          child: Text("Add Item"), 
        ), 
      ]), 
    ); 
  } 
}