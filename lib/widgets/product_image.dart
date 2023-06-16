import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {

  final String? image;
  const ProductImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( left: 10, right: 10, top: 10 ),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          child: image == null ? const Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover,) : FadeInImage(
            image: NetworkImage(image!), 
            placeholder: const AssetImage('assets/jar-loading.gif'),
            fit: BoxFit.cover,
          ),
      ),
    ),
  );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
    ]
  );
}