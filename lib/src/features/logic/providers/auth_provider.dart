import 'package:crush_app/src/core/helpers/utils.dart';
import 'package:crush_app/src/datasource/models/user/user_model.dart';
import 'package:crush_app/src/datasource/repositories/auth_repository.dart';
import 'package:crush_app/src/datasource/storage/local_storage.dart';
import 'package:crush_app/src/shared/locator.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  AuthRepository _authRepository = locator<AuthRepository>();
  String password = "";
  String phone = "";
  String dob = "";
  String sexe = "";
  String username = "";
  bool loader = false;
  UserModel user = UserModel.empty();

  bool isLoading = false;
  bool isLoadingLogin = false;
  String? errorMessage;
  String? errorMessageLogin;
  bool isSuccess = false;
  bool isSuccessLogIn = false;

  onChangeValue(key, value) {
    switch (key) {
      case "password":
        password = value;
        break;
      case "phone":
        phone = value;
        break;
      case "dob":
        dob = value;
        break;
      case "username":
        username = value;
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setLoadingLogin(bool value) {
    isLoadingLogin = value;
    notifyListeners();
  }

  void signup(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      _setLoading(true);
      final response = await _authRepository.register({
        'username': username,
        'password': password,
        'phone': phone,
        'dob': dob,
      });
      _setLoading(false);
      response.when(success: (data) {
        isSuccess = true;
        resetState();
        goTo(context, '/');
        notifyListeners();
      }, error: (error) {
        // print("error regis================== " + error.errorMessage);
        isSuccess = false;
        errorMessage = error.errorMessage;
        notifyListeners();
      });
    } catch (e) {
      _setLoading(false);
      // Passe l'état en "error" en cas d'échec
      errorMessage = e?.toString();
      errorMessageLogin = null;
      notifyListeners();
    }
    // errorMessageLogin = null;
    // notifyListeners();
  }

  void resetState() {
    isLoading = false;
    errorMessage = null;
    isSuccess = true;
    notifyListeners();
  }

  // Méthode pour gérer le login
  Future<void> login(BuildContext context) async {
    _setLoadingLogin(true);

    try {
      final response = await _authRepository.login({
        'phone': phone,
        'password': password,
      });

      response.when(
        success: (data) async {
          user = data;
          _setLoadingLogin(false);
          await LocalStorage().setObject('user', user.toJson());
          errorMessage = null;
          isSuccessLogIn = true;
          notifyListeners();
          goTo(context, '/home');
        },
        error: (error) {
          errorMessage = error.errorMessage;
          // user = null;
        },
      );
    } catch (e) {
      // Passe l'état en "error" en cas d'échec
      _setLoadingLogin(false);
      errorMessage = e?.toString();
      resetState();
    }

    _setLoadingLogin(false);
    // errorMessage = null;
    // notifyListeners();
  }
}
