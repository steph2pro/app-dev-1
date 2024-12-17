import 'package:flutter/material.dart';
import 'package:crush_app/src/core/theme/app_size.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';

class PageIndicators extends StatelessWidget {
  final int index;
  final int currentIndex;
  const PageIndicators({
    Key? key,
    required this.index,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => AnimatedContainer(
          height: currentIndex == index ? 15 : 11,
          margin: const EdgeInsets.only(right: AppSizes.p12),
          width: currentIndex == index ? 15 : 10,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: currentIndex == index
                ? context.colorScheme.primary
                : context.colorScheme.secondary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
