import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier{
  final String _baseUrl = dotenv.get('BASE_URL_SIGN_UP');
  final String _firebaseToken = dotenv.get('FIREBASE_TOKEN');

  Future<String?> createUser(String email, String password) async {

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken
    });

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedData = json.decode(response.body);
  }
}