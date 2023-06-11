import 'package:flutter/material.dart';

import '../models/products.dart';

class ProductsService extends ChangeNotifier{
  final String _baseUrl = "flutter-tuto-e8ea4-default-rtdb.firebaseio.com";

  final List<Product> products = [];
}