import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);
  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  updateAvailability( bool value ){
    product.available = value;
    notifyListeners();
  }
}