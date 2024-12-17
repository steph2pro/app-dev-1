import 'package:crush_app/src/shared/components/feed/post_card.dart';
import 'package:flutter/material.dart';

class UserFeed extends StatelessWidget {
  const UserFeed({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Expanded(
      child: ListView(
        children: List.generate(
            100,
            (index) => PostCard(
                  id: index,
                )),
      ),
    );
  }
}
