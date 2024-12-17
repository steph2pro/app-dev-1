import 'package:auto_route/auto_route.dart';
import 'package:crush_app/gen/assets.gen.dart';
import 'package:crush_app/src/datasource/models/dashboard/bottom_bar_model.dart';
import 'package:crush_app/src/features/ui/home/feed_screen.dart';
import 'package:crush_app/src/features/ui/home/home_screen.dart';
import 'package:crush_app/src/features/ui/home/profile_screen.dart';
import 'package:crush_app/src/features/ui/home/zim_chat_screen.dart';
import 'package:crush_app/src/shared/components/tools/custum_bottombar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardHomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const DashboardHomeScreen({super.key});

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<BottomBarModel> items = [
      BottomBarModel(
        label: "",
        iconData: Assets.images.homevideo,
        page: HomeScreen(),
        index: 0,
      ),
      BottomBarModel(
          label: "",
          iconData: Assets.images.homefeed,
          page: FeedScreen(),
          index: 1),
      BottomBarModel(
          label: "",
          iconData: Assets.images.homemessage,
          page: ZimChatScreen(),
          index: 2),
      BottomBarModel(
          label: "",
          iconData: Assets.images.homeprofile,
          page: ProfileScreen(),
          index: 3),
    ];

    return Scaffold(
      body: Stack(
        children: [
          items[currentIndex].page,
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: null,
                  child: CustomBottomBar(
                    items: items,
                    currentIndex: currentIndex,
                    onItemSelected: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }
}
