import 'package:auto_route/auto_route.dart';
import 'package:crush_app/src/core/helpers/utils.dart';
import 'package:crush_app/src/core/theme/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:crush_app/src/core/i18n/l10n.dart';
import 'package:crush_app/src/core/routing/app_router.dart';
import 'package:crush_app/src/shared/components/onboarding/onboarding_item.dart';
import 'package:crush_app/src/shared/components/onboarding/page_indicators.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF4EEF0),
      ),
      body: SafeArea(
        child:Container(
        // Ajout du LinearGradient ici
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF4EEF0), // Couleur 0%
                  Color(0xFFF2EDF4), // Couleur 26%
                  Color(0xFFE6EEF9), // Couleur 46%
                  Color(0xFFE7F2F6), // Couleur 75%
                  Color(0xFFEAF7F0), // Couleur 100%
                ],
                stops: [0.0, 0.25, 0.5, 0.75, 1.0],
              ),
            ),
            child:  Column(
            children: [
              Expanded(
                flex: 5, // Augmente l'espace alloué au contenu
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
            children: [
              OnboardingItem(
                imageUrl: 'assets/images/onboarding1.png',
                title: 'Rencontrez',
                description:
                    'Appuyez sur l’ecran pour commencer à rencontrer des personnes',
              ),
              OnboardingItem(
                imageUrl: 'assets/images/onboarding2.png',
                title: 'Decouvrez',
                description:
                    ' Appuyez sur l’ecran pour commencer à rencontrer des personnes',
              ),
              OnboardingItem(
                imageUrl: 'assets/images/onboarding3.png',
                title: 'Discutez ',
                description:
                    'Appuyez sur l’ecran pour commencer à rencontrer des personnes',
              ),
              OnboardingItem(
                imageUrl: 'assets/images/onboarding4.png',
                title: 'Invitez',
                description:
                    'Appuyez sur l’ecran pour commencer à rencontrer des personnes',
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2, // Diminue l'espace alloué à la section inférieure
          child: Column(
            children: [
              gapH20,
              PageIndicators(
                index: _currentIndex,
                currentIndex: _currentIndex,
              ),
              gapH20,
              if (_currentIndex != 3) ...[
                          SizedBox(
                            width: 137,
                            height: 47,
                            child: ElevatedButton(onPressed: (){
                            _controller.nextPage(
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.fastOutSlowIn);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(I18n.of(context).next,
                              textAlign: TextAlign.center,
                              ),
                              gapW6,
                              Icon(Icons.east,size: 20,)
                            ],
                          ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: context.colorScheme.onPrimary,
                              backgroundColor: context.colorScheme.primary ,
                            ),
                          ),
                          )
                          //  Button.primary(
                          //     height: 50,
                          //     title: I18n.of(context).next,
                          //     icon: Icon(Icons.chevron_right,size: 10,),
                          //     onPressed: (){
                                
                          //     },
                          //   ),

                        ]else ...[
                          SizedBox(
                            width: 137,
                            height: 47,
                            child: ElevatedButton(onPressed: (){
                                goTo(context, '/login');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Text(I18n.of(context).login_title),
                              gapW6,
                              Icon(Icons.east,size: 20,)
                            ],
                          ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: context.colorScheme.onPrimary,
                              backgroundColor: context.colorScheme.primary ,
                            ),
                          ),
                          ),
                          gapH16,
                          SizedBox(
                            width: 230,
                            height: 47,
                            child: ElevatedButton(onPressed: (){
                                goTo(context, '/login');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Text(I18n.of(context).login_googleBtnLabel),
                              gapW6,
                              Icon(Icons.east,size: 20,)
                            ],
                          ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: context.colorScheme.primary,
                              backgroundColor: context.colorScheme.onPrimary,
                            ),
                          ),
                          )

                        ],
            ]
          )
        )
        ])
        )
      )
      
    );
  }
}
