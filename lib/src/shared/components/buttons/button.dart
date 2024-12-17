import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  neutral,
  outline,
}

class Button extends StatelessWidget {
  const Button._({
    super.key,
    required this.title,
    this.onPressed,
    required this.type,
    this.icon,
    this.width,
    this.height,
    this.textSize,
    this.color,
  });

  factory Button.neutral({
    Key? key,
    required String title,
    Widget? icon,
    double? width,
    double? height,
    double? textSize,
    Color? color,
    VoidCallback? onPressed,
  }) {
    return Button._(
      key: key,
      title: title,
      icon: icon,
      width: width,
      height: height,
      textSize: textSize,
      color: color,
      onPressed: onPressed,
      type: ButtonType.neutral,
    );
  }

  factory Button.outline({
    Key? key,
    required String title,
    Widget? icon,
    double? width,
    double? height,
    double? textSize,
    Color? color,
    VoidCallback? onPressed,
  }) {
    return Button._(
      key: key,
      title: title,
      icon: icon,
      width: width,
      height: height,
      textSize: textSize,
      color: color,
      onPressed: onPressed,
      type: ButtonType.outline,
    );
  }

  factory Button.primary({
    Key? key,
    required String title,
    Widget? icon,
    double? width,
    double? height,
    double? textSize,
    Color? color,
    VoidCallback? onPressed,
  }) {
    return Button._(
      key: key,
      title: title,
      icon: icon,
      width: width,
      height: height,
      textSize: textSize,
      color: color,
      onPressed: onPressed,
      type: ButtonType.primary,
    );
  }

  final String title;
  final Widget? icon;
  final VoidCallback? onPressed;
  final ButtonType type;
  final double? width;
  final double? height;
  final double? textSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final label = Text(
      title,
      style: TextStyle(
        color: (type == ButtonType.primary || type == ButtonType.neutral)
            ? context.colorScheme.surface
            : context.colorScheme.primary,
        fontWeight: FontWeight.bold,
        fontSize: textSize ?? 12, // Réduction de la taille du texte
      ),
    );

    return SizedBox(
      width: width ?? 80, // Largeur par défaut réduite
      height: height ?? 30, // Hauteur par défaut réduite
      child: switch (type) {
        ButtonType.primary || ButtonType.neutral => ElevatedButton.icon(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              backgroundColor: color ?? context.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8), // Coins légèrement arrondis
              ),
            ),
            label: label,
            iconAlignment: IconAlignment.end,
            icon: icon ??
                const SizedBox(width: 0, height: 0), // Réduction des icônes
          ),
        ButtonType.outline => OutlinedButton.icon(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide(
                color: context.colorScheme.primary.withOpacity(0.6),
                width: 0.8, // Bordure fine
              ),
            ),
            icon: icon ?? const SizedBox(width: 0, height: 0),
            label: label,
            iconAlignment: IconAlignment.end,
          ),
      },
    );
  }
}
