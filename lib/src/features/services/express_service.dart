import 'package:zego_express_engine/zego_express_engine.dart';

class ExpressService {
  ExpressService._internal();

  factory ExpressService() => instance;
  static final ExpressService instance = ExpressService._internal();
  Future<void> init({
    required int appID,
    String appSign = '',
    ZegoScenario scenario = ZegoScenario.StandardVideoCall,
  }) async {
    // initEventHandle();
    final profile = ZegoEngineProfile(appID, scenario, appSign: appSign);
    await ZegoExpressEngine.createEngineWithProfile(profile);
  }
}
