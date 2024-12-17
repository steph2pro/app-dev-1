import 'dart:developer';

import 'package:dio/dio.dart';

class AuthApi {
  final Dio dio;

  AuthApi({required this.dio});

  // Créer un compte
  Future<Map<String, dynamic>> register(Map<String, dynamic> payload) async {
    final response = await dio.post('/auth/signup', data: payload);
    return response.data;
  }

  // Se connecter
  Future<Map<String, dynamic>> login(Map<String, dynamic> payload) async {
    log('body resuest : ' + payload.toString());
    final response = await dio.post('/auth/signin', data: payload);
    return response.data;
  }

  // Mot de passe oublié
  Future<void> forgotPassword(String email) async {
    await dio.post('/auth/forgot-password', data: {'email': email});
  }
}
