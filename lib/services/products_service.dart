import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/products.dart';

class ProductsService extends ChangeNotifier{
  final String _baseUrl = dotenv.get('BASE_URL');
  final List<Product> products = [];
  late Product selectedProduct;
  bool isLoading = true;
  bool isUpdating = false;

  ProductsService(){
    loadProduct();
  }

  Future<List<Product>> loadProduct() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json');
    final res = await http.get(url);
    final Map<String, dynamic> productMap = json.decode(res.body);

    productMap.forEach((key, value) { 
      final tempProduct = Product.fromJson(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }

Future saveOrCreateProduct( Product product ) async {
    isUpdating = true;
    notifyListeners();

    if(product.id == null){
      await createProduct(product);
    }else{
      await updateProduct(product);
    }

    isUpdating = false;
    notifyListeners();
}
  Future<String> updateProduct( Product product ) async {

    final url = Uri.https(_baseUrl, 'products/${ product.id }.json');
    await http.put(url, body: product.toJson() );
    
    final index = products.indexWhere((element) => element.id == product.id );
    products[index] = product;
    return product.id!;
  }

  Future<String> createProduct( Product product ) async {

    final url = Uri.https(_baseUrl, 'products.json');
    final res = await http.post(url, body: product.toJson() );
    final decodedData = json.decode(res.body);
    product.id = decodedData['name'];

    products.add(product);
    return product.id!;
  }
}