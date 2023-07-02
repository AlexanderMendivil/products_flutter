import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier{
  final String _baseUrl = dotenv.get('BASE_URL_SIGN_UP');
  final String _firebaseToken = dotenv.get('FIREBASE_TOKEN');

  final storage = const FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken
    });

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedData = json.decode(response.body);

    if(decodedData.containsKey('idToken')){
      await storage.write(key: 'token', value: decodedData['idToken']);
      return null;
    }
    return decodedData['error']['message'];
  }
  Future<String?> login(String email, String password) async {

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken
    });

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedData = json.decode(response.body);

    if(decodedData.containsKey('idToken')){
       await storage.write(key: 'token', value: decodedData['idToken']);
      return null;
    }
    return decodedData['error']['message'];
  }

  Future logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}