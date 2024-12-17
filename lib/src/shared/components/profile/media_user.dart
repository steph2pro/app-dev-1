import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class MediaUser extends StatelessWidget {
  const MediaUser({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      // height: size.height / 3,
      color: context.colorScheme.secondary,
      child: Text("Media"),
    );
  }
}
