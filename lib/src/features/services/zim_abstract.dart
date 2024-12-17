import 'package:zego_zimkit/zego_zimkit.dart';

abstract class ZIM {
  Future<ZIMCallInvitationSentResult> callInvite(
      List<String> invitees, ZIMCallInviteConfig config);

  Future<ZIMCallingInvitationSentResult> callingInvite(
      List<String> invitees, String callID, ZIMCallingInviteConfig config);

  Future<ZIMCallCancelSentResult> callCancel(
      List<String> invitees, String callID, ZIMCallCancelConfig config);

  Future<ZIMCallAcceptanceSentResult> callAccept(
      String callID, ZIMCallAcceptConfig config);

  Future<ZIMCallRejectionSentResult> callReject(
      String callID, ZIMCallRejectConfig config);

  Future<ZIMCallEndSentResult> callEnd(String callID, ZIMCallEndConfig config);

  Future<ZIMCallQuitSentResult> callQuit(
      String callID, ZIMCallQuitConfig config);
}
