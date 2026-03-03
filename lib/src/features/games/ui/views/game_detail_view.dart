import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/games/ui/components/game_hero.dart';
import 'package:casino_platform_test/src/features/games/ui/components/game_detail_metrics.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/app_badge.dart';
import 'package:casino_platform_test/src/shared/ui/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Game details UI view.
class CPGameDetailView extends StatelessWidget {
  /// Creates [CPGameDetailView].
  const CPGameDetailView({
    required this.game,
    super.key,
  });

  final CPGameViewModel game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.only(bottom: 20.h),
        children: <Widget>[
          SizedBox(
            height: 250.h,
            child: CPGameImageHero(
              gameId: game.id,
              child: Image.network(game.headerUrl, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(game.name, style: CPAppTextStyles.h1),
                SizedBox(height: 8.h),
                CPAppBadge(label: game.categoryLabel),
                SizedBox(height: 14.h),
                CPGameDetailMetrics(
                  provider: game.providerLabel,
                  rtp: game.rtpLabel,
                  volatility: game.volatilityLabel,
                ),
                SizedBox(height: 14.h),
                Text(game.description, style: CPAppTextStyles.body),
                SizedBox(height: 18.h),
                CPAppButton(
                  label: context.l10n.playNow,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
