import 'package:crush_app/src/datasource/models/dashboard/bottom_bar_model.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {
  final List<BottomBarModel> items;
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: currentIndex != 0 ? context.colorScheme.onPrimary : null,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((element) {
          final isSelected = element.index == currentIndex;
          return GestureDetector(
            onTap: () => onItemSelected(element.index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  element.icon,
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? context.colorScheme.primary
                        : currentIndex != 0
                            ? context.colorScheme.tertiary
                            : context.colorScheme.onPrimary,
                    BlendMode.srcIn,
                  ),
                  width: isSelected ? 30 : 25,
                  height: isSelected ? 30 : 25,
                ),
                // const SizedBox(height: 4),
                // Text(
                //   element.label,
                //   style: TextStyle(
                //     fontSize: 12,
                //     color: isSelected
                //         ? context.colorScheme.primary
                //         : context.colorScheme.tertiary,
                //   ),
                // ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
