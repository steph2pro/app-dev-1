import 'package:auto_route/auto_route.dart';
import 'package:crush_app/src/core/helpers/utils.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/datasource/models/tools/tab_bar_model.dart';
import 'package:crush_app/src/datasource/storage/local_storage.dart';
import 'package:crush_app/src/shared/components/buttons/button.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/components/profile/media_user.dart';
import 'package:crush_app/src/shared/components/profile/profit_user.dart';
import 'package:crush_app/src/shared/components/profile/subcription_user.dart';
import 'package:crush_app/src/shared/components/profile/user_feed.dart';
import 'package:crush_app/src/shared/components/tools/custum_tab_bar.dart';
import 'package:crush_app/src/shared/components/tools/render_avatar.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget implements AutoRouteWrapper {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<TabBarModel> tabs = [
      TabBarModel(title: "Publications", content: UserFeed()),
      TabBarModel(title: "Medias", content: MediaUser()),
      TabBarModel(title: "Abonnement", content: SubscriptionUser()),
      TabBarModel(title: "Gains", content: ProfitUser())
    ];
    var size = MediaQuery.of(context).size;

    String avatarUrl =
        'https://st.depositphotos.com/2931363/3703/i/450/depositphotos_37034497-stock-photo-young-black-man-smiling-at.jpg';
    return Scaffold(
      backgroundColor: context.colorScheme.outlineVariant.withOpacity(0.1),
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            children: [
              Container(
                  color: context.colorScheme.onPrimary,
                  constraints: BoxConstraints(maxHeight: size.height / 3),
                  child: Stack(
                    clipBehavior: Clip
                        .none, // Permet à l'avatar de dépasser la zone du conteneur
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Photo de couverture
                      Container(
                        height: 100, // Hauteur de la couverture
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage(avatarUrl), // Image de couverture
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Fond blanc sous l'avatar
                      Positioned(
                        bottom: -size.height / 10,
                        child: Container(
                          width: size.width,
                          height: size.height /
                              10, // Hauteur suffisante pour couvrir l'avatar
                          color: Colors.white, // Fond blanc
                        ),
                      ),
                      // Cercle pour la photo de profil
                      Positioned(
                        bottom:
                            -50, // Décalage pour que l'avatar chevauche la couverture
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              Colors.white, // Bord blanc autour de l'avatar
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RenderAvatar(
                              isWithStatus: true,
                              isOnline: true,
                              size: 45,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Gap.vertical(height: Dimens.tripleSpacing),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: context.colorScheme.onPrimary,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Dimens.radius),
                        bottomRight: Radius.circular(Dimens.radius))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Angie Kelly, 24',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap.vertical(height: Dimens.spacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              // await LocalStorage().remove('user');
                              // context.router.push(const TestChatRoute());
                            },
                            child: Text(
                              "Douala",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          )
                        ],
                      ),
                      Gap.vertical(height: Dimens.spacing),
                      Text(
                        "Je m’ennuie chez moi qui m’invite dans un resto chic ? c’est toi qui paie hein mon chaud ❤️🥰🍑🍑 ...",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Gap.vertical(height: Dimens.spacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Button.outline(
                            title: "Modifier",
                            textSize: 10,
                            width: 100,
                            icon: Icon(
                              Icons.add,
                              size: 10,
                            ),
                          ),
                          Button.outline(
                            title: "Verification",
                            textSize: 10,
                            width: 100,
                            icon: Icon(
                              Icons.add,
                              size: 10,
                            ),
                          ),
                          Button.outline(
                            title: "Parametres",
                            textSize: 10,
                            width: 100,
                            icon: Icon(
                              Icons.add,
                              size: 10,
                            ),
                            onPressed: () async {
                              await LocalStorage().remove("user");
                              goTo(context, '/');
                            },
                          ),
                        ],
                      ),
                      Gap.vertical(height: Dimens.spacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "123",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Followers",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "85",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Suivis",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "13",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Invitations",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context.colorScheme.primary,
                                borderRadius:
                                    BorderRadius.circular(Dimens.radius)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "230 💎",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: context.colorScheme.onPrimary,
                                    ),
                                  ),
                                  Text(
                                    "Diamants",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: context.colorScheme.onPrimary,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Gap.vertical(height: Dimens.spacing),
              Expanded(
                child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        color: context.colorScheme.onPrimary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimens.radius),
                            topRight: Radius.circular(Dimens.radius))),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: CustumTabBar(
                        tabs: tabs,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    // TODO: implement wrappedRoute
    throw UnimplementedError();
  }
}
