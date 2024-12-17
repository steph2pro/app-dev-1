import 'package:crush_app/src/shared/components/onboarding/page_indicators.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:crush_app/src/core/theme/app_size.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter_svg/svg.dart';


class OnboardingItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? titlecolor;
  final String? titlesecond;
  final String description;

  const OnboardingItem({
    super.key,
    required this.imageUrl,
    required this.title,this.titlecolor,this.titlesecond,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return 
    Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Spacer(),
            // Expanded(
            //   child: 
              Image.asset(
                imageUrl,
                width: double.infinity,
                height:400,
              ),
            // ),
            gapH30,
             Column(
                children: [
                  Text('${title} ', // Texte traduit
                      style: context.textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w700)
                  ),
                    
                  gapH16,
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall
                  ),
                ],
              ),
            
          ],
        ),
    ).animate().scale(delay: 50.milliseconds).fadeIn();
  }
}
