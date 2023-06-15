import 'package:flutter/material.dart';
import 'package:products/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(image: product.picture!),
            _ProductDetails(product: product),
            Positioned(top: 0,right: 0,child: PriceTag(price: product.price,)),
            Positioned(top: 0,left: 0,child: _NotAvailable(available: product.available,)),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 7)
      )
    ]
  );
}

class _NotAvailable extends StatelessWidget {
  final bool available;
  const _NotAvailable({required this.available});

  @override
  Widget build(BuildContext context) {

    if(!available){
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))  
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('No disponible', style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
      ),
    );
  }else{
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.green[800],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))  
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Disponible', style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
      ),
    );
  }
  }
}

class PriceTag extends StatelessWidget {
  final double price;
  const PriceTag({
    super.key, required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        width: 100,
        height: 70,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(price.toString(), style: const TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;
  const _ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only( right: 50 ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(product.name,
           style: const TextStyle(
            fontSize: 20, 
            color: Colors.white, 
            fontWeight: FontWeight.bold
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(product.id!,
           style: const TextStyle(
            fontSize: 15, 
            color: Colors.white, 
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ]),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25) )
  );
}

class _BackgroundImage extends StatelessWidget {
  final String image;
  const _BackgroundImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'), image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}