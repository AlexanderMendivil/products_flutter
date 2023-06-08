import 'package:flutter/material.dart';
import 'package:products/ui/input_decorations.dart';
import 'package:products/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(children: [
            const ProductImage(),
            Positioned(
              top: 60,
              left: 20,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(), 
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,)),
              ),      
            Positioned(
              top: 60,
              right: 20,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(), 
                icon: const Icon(Icons.camera_alt_outlined, color: Colors.white,)),
              )      
          ],),
          const _ProductForm(),
          const SizedBox(height: 100,)
        ],),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.save_outlined),onPressed: (){}),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 300,
        decoration: _buildBoxDecoration(),
        child: Form(child: 
        Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecorations.authInputDecoration(hintText: 'Nombre del producto', labelText: 'Nombre'),
            ),
            const SizedBox(height: 30),
            
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(hintText: '\$150', labelText: 'Precio'),
            ),

            const SizedBox(height: 30),
            
            SwitchListTile.adaptive(value: true,title: const Text("Disponible"), activeColor: Colors.indigo, onChanged: (value){

            }),

            const SizedBox(height: 30),
          ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0,5), blurRadius: 5)
    ]
  );
}