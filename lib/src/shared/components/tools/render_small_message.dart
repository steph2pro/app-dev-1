import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class RenderSmallMessage extends StatelessWidget {
  final String message;
  final String? avatar;
  const RenderSmallMessage({super.key, required this.message, this.avatar});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              height: 35,
              child: avatar == null
                  ? null
                  : CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(avatar!),
                    )),
          Container(
            constraints: BoxConstraints(
              maxWidth: size.width / 2.2,
              minWidth: 0,
            ),
            // width: size.width / 2.2,
            decoration: BoxDecoration(
                color: context.colorScheme.onPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Dimens.radius)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: TextStyle(
                  color: context.colorScheme.onPrimary,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
