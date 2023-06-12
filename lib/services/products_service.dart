import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/products.dart';

class ProductsService extends ChangeNotifier{
  final String _baseUrl = dotenv.get('BASE_URL');

  final List<Product> products = [];
}