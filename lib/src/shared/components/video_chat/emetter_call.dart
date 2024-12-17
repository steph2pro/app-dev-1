import 'package:crush_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class EmetterCall extends StatelessWidget {
  final Widget? emetter;
  const EmetterCall({super.key, this.emetter});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: emetter ??
            Assets.images.homeimagePng.image(
              width: 100,
              height: 160,
              fit: BoxFit.cover,
            ));
  }
}
