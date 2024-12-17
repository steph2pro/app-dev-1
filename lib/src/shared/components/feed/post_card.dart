import 'package:crush_app/gen/assets.gen.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/shared/components/buttons/button.dart';
import 'package:crush_app/src/shared/components/feed/post_carrousel.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/components/tools/render_avatar.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostCard extends StatelessWidget {
  int id;
  PostCard({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: context.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(Dimens.radius)),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RenderAvatar(
                        size: 20,
                      ),
                      Gap.horizontal(width: Dimens.spacing),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '@lamyyourG',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          Row(
                            children: [
                              Text(
                                "il y'a 2 min",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: context.colorScheme.onSurface
                                        .withOpacity(0.5)),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                    left: 4,
                                    right: 4,
                                  ),
                                  child: SvgPicture.asset(Assets.images.dot)),
                              Text(
                                "à Douala",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: context.colorScheme.onSurface
                                        .withOpacity(0.5)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Button.primary(
                        onPressed: () {},
                        title: "Suivre",
                        width: 90,
                        height: 40,
                        textSize: 11,
                        icon: Icon(
                          Icons.add,
                          color: context.colorScheme.onPrimary,
                          size: 11,
                        ),
                      ),
                      Gap.horizontal(width: Dimens.spacing),
                      SvgPicture.asset(Assets.images.threedot),
                    ],
                  ),
                ],
              ),
              Gap.vertical(height: Dimens.doubleSpacing),
              Text(
                  "Je m’ennuie chez moi qui m’invite dans un resto chic ? c’est toi qui paie hein mon chaud ❤️🥰🍑🍑 ..."),
              Gap.vertical(height: Dimens.spacing),
              Container(
                child: id % 2 == 0 ? PostCarrousel() : null,
              ),
              Gap.vertical(height: Dimens.spacing),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Button.outline(
                          onPressed: () {},
                          title: "Amitié",
                          textSize: 9,
                          height: 30,
                          width: 60,
                          icon: SvgPicture.asset(
                            Assets.images.friendicon,
                            width: 10,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Button.primary(
                            onPressed: () {},
                            color: Color(0xFF74DC42),
                            title: "Inviter",
                            textSize: 9,
                            height: 30,
                            width: 60,
                            icon: SvgPicture.asset(
                              Assets.images.glassicon,
                              width: 10,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          Assets.images.icongift,
                          width: 30,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            // Icon(
                            //   Icons.thumb_up_alt_outlined,
                            //   size: 20,
                            // ),
                            SvgPicture.asset(
                              Assets.images.likeicon,
                              width: size.width / 25,
                            ),
                            Gap.horizontal(width: Dimens.minSpacing),
                            Text(
                              "134",
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Dimens.spacing / 2,
                              right: Dimens.spacing / 2),
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.mode_comment_outlined,
                              //   size: 20,
                              // ),
                              SvgPicture.asset(
                                Assets.images.commenticon,
                                width: size.width / 25,
                              ),
                              Gap.horizontal(width: Dimens.minSpacing),
                              Text(
                                "134",
                                style: TextStyle(fontSize: 11),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            // Icon(
                            //   Icons.share_outlined,
                            //   size: 20,
                            // ),
                            SvgPicture.asset(
                              Assets.images.shareicon,
                              width: size.width / 25,
                            ),
                            Gap.horizontal(width: Dimens.minSpacing),
                            Text(
                              "134",
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
