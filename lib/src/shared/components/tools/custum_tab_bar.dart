import 'package:crush_app/src/datasource/models/tools/tab_bar_model.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CustumTabBar extends StatefulWidget {
  final List<TabBarModel> tabs;

  const CustumTabBar({super.key, required this.tabs});

  @override
  State<CustumTabBar> createState() => _CustumTabBarState();
}

class _CustumTabBarState extends State<CustumTabBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            width: size.width,
            height: size.height / 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  widget.tabs.length,
                  (index) => InkWell(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.tabs[index].title,
                          style: TextStyle(
                              fontSize: 10,
                              color: index == _currentIndex
                                  ? context.colorScheme.primary
                                  : context.colorScheme.tertiary),
                        ),
                      ))),
            )),
        Expanded(child: widget.tabs[_currentIndex].content)
      ],
    );
  }
}
