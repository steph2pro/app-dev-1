import 'package:crush_app/src/features/ui/auth/login_screen.dart';
import 'package:crush_app/src/features/ui/auth/signup_screen.dart';
import 'package:crush_app/src/features/ui/chat/single_chat_screen.dart';
import 'package:crush_app/src/features/ui/dashboard_home.dart';
import 'package:crush_app/src/features/ui/onboarding/onboarding_screen.dart';
import 'package:crush_app/src/features/ui/video_chat/video_chat_proposal_screen.dart';
import 'package:flutter/material.dart';

class DashboardParams {
  final String name;
  final String id;

  DashboardParams({required this.name, required this.id});
}

var routes = {
  "/": (context) => OnboardingScreen(),
  "/login": (context) => LoginScreen(),
  "/home": (context) => DashboardHomeScreen(),
  "/signup": (context) => SignUpScreen(),
  "/single-chat": (context) => SingleChatScreen(
        chatId: ModalRoute.of(context)!.settings.arguments as String,
      ),
  "/video-call-proposal": (context) => VideoChatProposalScreen(),
};
