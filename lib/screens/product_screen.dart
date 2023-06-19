import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products/providers/providers.dart';
import 'package:products/services/services.dart';
import 'package:products/ui/input_decorations.dart';
import 'package:products/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductsScreenBody(productService: productService),
      );
  }
}

class _ProductsScreenBody extends StatelessWidget {
  const _ProductsScreenBody({
    super.key,
    required this.productService,
  });

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(children: [
            ProductImage(image: productService.selectedProduct.picture,),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save_outlined),
        onPressed: () async {
          if(!productForm.isValidForm()) return;
          
          await productService.saveOrCreateProduct(productForm.product);
          
        }),
    );
  }
}

class _ProductForm extends StatelessWidget {

  const _ProductForm();

  @override
  Widget build(BuildContext context) {
  final productForm = Provider.of<ProductFormProvider>(context);
  final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 300,
        decoration: _buildBoxDecoration(),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: productForm.formKey,
          child: 
        Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecorations.authInputDecoration(hintText: 'Nombre del producto', labelText: 'Nombre'),
              initialValue: product.name,
              onChanged: ( value ) => product.name = value,
              validator: ( value ) {
                if(value == null || value.isEmpty ){
                  return 'El nombre es obligatorio';

                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(hintText: '\$150', labelText: 'Precio'),
              initialValue: product.price.toString(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              onChanged: ( value ){
                if(double.tryParse(value) == null){
                  product.price = 0;
                  }else{
                    product.price = double.parse(value);
                  }
                },
            ),

            const SizedBox(height: 30),
            
            SwitchListTile.adaptive(
              value: product.available, 
              title: const Text("Disponible"), 
              activeColor: Colors.indigo, 
              onChanged: productForm.updateAvailability
            ),

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