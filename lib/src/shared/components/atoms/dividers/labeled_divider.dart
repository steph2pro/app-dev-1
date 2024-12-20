// Drawing a divider with some text in the center
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class LabeledDivider extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry labelPadding;
  final Color? labelBackgroundColor;
  final Alignment labelAlignment;

  const LabeledDivider({
    required this.label,
    this.labelPadding = const EdgeInsets.symmetric(horizontal: Dimens.spacing),
    super.key,
    this.labelBackgroundColor,
    this.labelAlignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: labelAlignment,
      children: [
        const Divider(),
        Container(
          padding: labelPadding,
          color: labelBackgroundColor ?? context.colorScheme.surface,
          child: Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(.8)),
          ),
        )
      ],
    );
  }
}
