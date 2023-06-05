import 'package:flutter/material.dart';
import 'package:products/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'),),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) => const ProductCard()),
    
    floatingActionButton: FloatingActionButton(onPressed: () {  },
    child: const Icon(Icons.add)),
    );
  }
}