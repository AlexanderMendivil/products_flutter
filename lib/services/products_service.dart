import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/products.dart';

class ProductsService extends ChangeNotifier{
  final String _baseUrl = dotenv.get('BASE_URL');
  final List<Product> products = [];
  late Product selectedProduct;
  bool isLoading = true;
  bool isUpdating = false;
  File? newPictureImage;

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

  void updateSelectedProductImage(String path){

    selectedProduct.picture = path; 
    newPictureImage = File.fromUri(Uri( path: path ));

    notifyListeners();
  }


  Future<String?> uploadImage() async {
    if( newPictureImage == null ) return null;

    isUpdating = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dact0lkma/image/upload?upload_preset=umlzepjl');

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', newPictureImage!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final response = await http.Response.fromStream(streamResponse);

   if( response.statusCode != 200 && response.statusCode != 201 ) return null;

    newPictureImage = null;
    final decodedData = json.decode(response.body);
    return decodedData['secure_url'];
  }
}