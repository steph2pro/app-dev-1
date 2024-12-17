class Environment {
  static const String environment =
      String.fromEnvironment('env', defaultValue: 'dev');
  static const String baseUrl = String.fromEnvironment('base_url',
      defaultValue:
          'https://crush.lasolutions.net'); //https://crush.lasolutions.net
  static const int appID =
      int.fromEnvironment('app_id', defaultValue: 497357553);
  static const String appSign = String.fromEnvironment('app_sign',
      defaultValue:
          '4ab81315b952f02540723a6a6fdf22692885a7a6a761aff9377e96635efb6ba8');
}
