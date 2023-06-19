import 'package:flutter/material.dart';
import 'package:products/models/models.dart';
import 'package:products/screens/screens.dart';
import 'package:products/services/services.dart';
import 'package:products/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);
    
    if( productService.isLoading ) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(title: const Text('Home'),),
      body: ListView.builder(
        itemCount: productService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: ProductCard(product: productService.products[index],), 
          onTap: (){
            productService.selectedProduct = productService.products[index].copy();
             Navigator.pushNamed(context, 'product');

             
             },
          )
        ),
    
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        productService.selectedProduct = Product(available: true, name: '', price: 0);
         Navigator.pushNamed(context, 'product');
           },
    child: const Icon(Icons.add)),
    );
  }
}