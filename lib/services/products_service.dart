import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/products.dart';

class ProductsService extends ChangeNotifier{
  final String _baseUrl = dotenv.get('BASE_URL');
  final List<Product> products = [];
  bool isLoading = true;

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
}