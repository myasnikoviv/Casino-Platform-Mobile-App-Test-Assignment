import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/games/ui/components/game_hero.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';
import 'package:casino_platform_test/src/shared/ui/app_badge.dart';
import 'package:casino_platform_test/src/shared/ui/app_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Game grid card with direct tap-to-open interaction.
class CPGameCard extends StatelessWidget {
  /// Creates [CPGameCard].
  const CPGameCard({
    required this.game,
    required this.onOpen,
    super.key,
  });

  /// Rendered game view model.
  final CPGameViewModel game;

  /// Callback triggered on card tap.
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpen,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        elevation: 1.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: CPGameImageHero(
                gameId: game.id,
                child: CPAppCachedNetworkImage(
                  imageUrl: game.thumbnailUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.w),
              child: SizedBox(
                height: 56.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      game.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CPAppTextStyles.label,
                    ),
                    CPAppBadge(label: game.categoryLabel),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
