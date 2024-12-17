import 'package:crush_app/src/datasource/http/auth_api.dart';
import 'package:crush_app/src/datasource/http/dio_config.dart';
import 'package:crush_app/src/datasource/models/api_response/api_response.dart';
import 'package:crush_app/src/datasource/models/user/user_model.dart';
import 'package:crush_app/src/datasource/repositories/base_repository.dart';
import 'package:crush_app/src/shared/locator.dart';

class AuthRepository extends BaseRepository {
  final AuthApi authApi;

  AuthRepository({
    AuthApi? authApi,
  }) : authApi = authApi ?? AuthApi(dio: locator<DioConfig>().dio);

  // Créer un compte
  Future<ApiResponse<Map<String, dynamic>, ApiError>> register(
      Map<String, dynamic> payload) async {
    return runApiCall(
      call: () async {
        final response = await authApi.register(payload);
        return ApiResponse.success(response);
      },
    );
  }

  // Se connecter
  Future<ApiResponse<UserModel, ApiError>> login(
      Map<String, dynamic> payload) async {
    return runApiCall(
      call: () async {
        final response = await authApi.login(payload);
        return ApiResponse.success(UserModel.fromJson(response));
      },
    );
  }

  // Mot de passe oublié
  Future<ApiResponse<void, ApiError>> forgotPassword(String email) async {
    return runApiCall(
      call: () async {
        await authApi.forgotPassword(email);
        return ApiResponse.success(null); // Pas de réponse à retourner
      },
    );
  }
}
