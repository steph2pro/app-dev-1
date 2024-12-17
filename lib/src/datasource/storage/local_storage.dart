import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<String> get(String key) async {
    // Récupérer la chaîne de caractères
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key);
    return data ?? "";
  }

  Future<void> set(String key, String data) async {
// Stocker une chaîne de caractères
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  Future<void> remove(String key) async {
// Stocker une chaîne de caractères
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<bool> setObject<T>(String key, T data) async {
    final prefs = await SharedPreferences.getInstance();

    String myObjectsJson = jsonEncode(data);
    var result = await prefs.setString(key, myObjectsJson);

    return result;
  }

  Future<T?> getObject<T>(
      String key, T Function(Map<String, dynamic>) fromJson) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString == null) {
      return null; // Retourne null si l'objet n'existe pas
    }

    try {
      // Remplace les guillemets simples par des guillemets doubles si nécessaire
      String formattedJson = jsonString.replaceAll("'", '"');

      // Tente de décoder le JSON formaté
      final Map<String, dynamic> jsonData = jsonDecode(formattedJson);
      log(jsonData.toString());
      return fromJson(jsonData); // Convertit le JSON en objet T
    } catch (e) {
      print('Erreur lors du décodage de l\'objet: $e');
      return null;
    }
  }
}
