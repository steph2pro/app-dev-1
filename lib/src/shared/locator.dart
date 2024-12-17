import 'package:crush_app/src/core/routing/app_router.dart';
import 'package:crush_app/src/datasource/http/auth_api.dart';
import 'package:crush_app/src/datasource/http/dio_config.dart';
import 'package:crush_app/src/datasource/http/example_api.dart';
import 'package:crush_app/src/datasource/repositories/auth_repository.dart';
import 'package:crush_app/src/datasource/repositories/chat_repository.dart';
import 'package:crush_app/src/datasource/repositories/example_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance
  ..registerLazySingleton(() => DioConfig())
  // ..registerLazySingleton(() => AppRouter())
  ..registerLazySingleton(() => ExampleApi(dio: locator<DioConfig>().dio))
  ..registerLazySingleton(() => ExampleRepository())
  ..registerLazySingleton(() => AuthApi(dio: locator<DioConfig>().dio))
  ..registerLazySingleton(() => AuthRepository())
  ..registerLazySingleton(() => ChatRepository());
