import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TestChatScreen extends StatelessWidget implements AutoRouteWrapper {
  const TestChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat'),
      ),
      body: Container(),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}
