import 'dart:developer';

import 'package:crush_app/main.dart';
import 'package:crush_app/src/core/environment.dart';
import 'package:crush_app/src/datasource/models/user/user_model.dart';
import 'package:crush_app/src/datasource/storage/local_storage.dart';
import 'package:dio/dio.dart';

final _logInterceptor = LogInterceptor(
  logPrint: (object) => log(object.toString()),
  request: true,
  requestHeader: true,
  requestBody: true,
  responseBody: true,
);

class DioConfig {
  final Dio dio;

  DioConfig({Dio? dio})
      : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: Environment.baseUrl,
                headers: {
                  'Accept': 'application/json',
                },
                contentType: 'application/json',
              ),
            ) {
    this.dio.interceptors.add(_logInterceptor);
    this.dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              // Récupération du token avant chaque requête
              String? token = await _getToken();
              if (token != null && token.isNotEmpty) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              handler.next(options);
            },
            onError: (error, handler) {
              log('Request Error: ${error.response?.statusCode}');

              if (error.response?.statusCode == 401) {
                // Redirection vers la page de login
                // On peut utiliser pushNamedAndRemoveUntil pour s'assurer de réinitialiser la navigation
                navigatorKey.currentState
                    ?.pushNamedAndRemoveUntil('/', (route) => false);
              }

              handler.next(error); // Continuer après le traitement de l'erreur
            },
          ),
        );
  }

  static Future<String?> _getToken() async {
    try {
      var user = await LocalStorage().getObject("user", UserModel.fromJson);
      return user?.accessToken;
    } catch (e) {
      log('Error fetching token: $e');
      return null;
    }
  }
}
