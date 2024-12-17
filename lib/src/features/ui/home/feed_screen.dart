import 'package:auto_route/auto_route.dart';
import 'package:crush_app/gen/assets.gen.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/shared/components/feed/post_card.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class FeedScreen extends StatelessWidget implements AutoRouteWrapper {
  const FeedScreen({super.key});
  Future<void> _onRefesh() async {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        // appBar: AppBar(toolbarHeight: 0),
        backgroundColor: context.colorScheme.outlineVariant.withOpacity(0.1),
        body: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: _onRefesh,
            child: Container(
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF4EEF0), // Couleur #F4EEF0
                    Color(0xFFF2EDF4), // Couleur #F2EDF4
                    Color(0xFFE6EEF9), // Couleur #E6EEF9
                    Color(0xFFE7F2F6), // Couleur #E7F2F6
                    Color(0xFFEAF7F0), // Couleur #EAF7F0
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Gap.vertical(height: Dimens.doubleSpacing),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimens.spacing, right: Dimens.spacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Publications",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Gap.horizontal(width: Dimens.spacing),
                            Text(
                              "Favoris",
                              style: TextStyle(
                                  color: context.colorScheme.tertiary
                                      .withOpacity(0.3)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(Assets.images.notificationicon),
                            const Gap.horizontal(width: Dimens.spacing),
                            SvgPicture.asset(Assets.images.addicon),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: size.height - 100,
                    child: ListView(
                      children: List.generate(
                          100,
                          (index) => PostCard(
                                id: index,
                              )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    // TODO: implement wrappedRoute
    throw UnimplementedError();
  }
}
