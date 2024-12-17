import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class RenderAvatar extends StatelessWidget {
  final bool isWithStatus; // Afficher le statut ou non
  final bool isOnline; // En ligne ou non
  final String avatarUrl; // URL de l'avatar
  final String? name;
  final double size;

  const RenderAvatar({
    Key? key,
    this.isWithStatus = false,
    this.isOnline = false,
    this.name,
    this.size = 30,
    this.avatarUrl =
        'https://st.depositphotos.com/2931363/3703/i/450/depositphotos_37034497-stock-photo-young-black-man-smiling-at.jpg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double badgeSize = 14;
    return Stack(
      clipBehavior:
          Clip.none, // Permet au statut de dépasser légèrement l'avatar
      children: [
        // Avatar principal
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              radius: size, // Taille de l'avatar
              backgroundImage: NetworkImage(avatarUrl),
            ),
            Container(
                child: name != null
                    ? Text(
                        name!,
                        style:
                            TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                      )
                    : null),
          ],
        ),

        if (isWithStatus)
          Padding(
            padding: EdgeInsets.only(left: size * 1.5, top: size * 1.5),
            child: Container(
              height: badgeSize, // Taille du point
              width: badgeSize, // Taille du point
              decoration: BoxDecoration(
                color: isOnline
                    ? Color(0XFF8ED161)
                    : context.colorScheme.tertiary
                        .withOpacity(.3), // Vert si en ligne, rouge sinon
                shape: BoxShape.circle, // Point circulaire
                border: Border.all(
                  color: Colors.white, // Bordure blanche pour contraste
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
