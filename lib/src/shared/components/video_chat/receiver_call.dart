import 'package:crush_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ReceiverCall extends StatelessWidget {
  const ReceiverCall({super.key});

  @override
  Widget build(BuildContext context) {
    return Assets.images.person1.image(
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
