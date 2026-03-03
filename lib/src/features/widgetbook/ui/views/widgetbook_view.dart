import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/games/ui/components/game_card.dart';
import 'package:casino_platform_test/src/features/games/ui/components/promo_carousel.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/app_badge.dart';
import 'package:casino_platform_test/src/shared/ui/app_button.dart';
import 'package:casino_platform_test/src/shared/ui/app_loading_skeleton.dart';
import 'package:casino_platform_test/src/shared/ui/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widgetbook view.
class CPWidgetbookView extends StatefulWidget {
  /// Creates [CPWidgetbookView].
  const CPWidgetbookView({super.key});

  @override
  State<CPWidgetbookView> createState() => _CPWidgetbookViewState();
}

class _CPWidgetbookViewState extends State<CPWidgetbookView> {
  final TextEditingController _sampleController = TextEditingController();
  static const CPGameViewModel _sampleGame = CPGameViewModel(
    id: 'widgetbook-game',
    name: 'Daily Tournament',
    categoryLabel: 'Live Casino',
    providerLabel: 'Casino Platform',
    rtpLabel: '96.30%',
    volatilityLabel: 'Medium',
    description: 'Widgetbook sample game card for design review.',
    thumbnailUrl: 'https://picsum.photos/seed/widgetbook-game/500/300',
    headerUrl: 'https://picsum.photos/seed/widgetbook-game-header/1200/600',
  );

  @override
  void dispose() {
    _sampleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(12.w),
      children: <Widget>[
        Text(context.l10n.themeTokens, style: CPAppTextStyles.h2),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          children: const <Widget>[
            _CPColorDot(color: CPAppColors.primary),
            _CPColorDot(color: CPAppColors.accent),
            _CPColorDot(color: CPAppColors.warning),
          ],
        ),
        SizedBox(height: 14.h),
        Text(context.l10n.typography, style: CPAppTextStyles.h2),
        SizedBox(height: 8.h),
        Text(context.l10n.passwordSavedTitle, style: CPAppTextStyles.h1),
        SizedBox(height: 6.h),
        Text(context.l10n.gamesTab, style: CPAppTextStyles.h2),
        SizedBox(height: 6.h),
        Text(
          context.l10n.passwordSavedDescription,
          style: CPAppTextStyles.body,
        ),
        SizedBox(height: 6.h),
        Text(
          context.l10n.categorySlots,
          style: CPAppTextStyles.label,
        ),
        SizedBox(height: 14.h),
        Text(context.l10n.sharedWidgets, style: CPAppTextStyles.h2),
        SizedBox(height: 8.h),
        CPAppTextField(
          controller: _sampleController,
          label: context.l10n.sampleInput,
        ),
        SizedBox(height: 8.h),
        CPAppButton(label: context.l10n.primaryButton, onPressed: () {}),
        SizedBox(height: 8.h),
        const CPAppBadge(label: 'Badge'),
        SizedBox(height: 8.h),
        CPAppLoadingSkeleton(height: 80.h),
        SizedBox(height: 14.h),
        Text(context.l10n.gamesTab, style: CPAppTextStyles.h2),
        SizedBox(height: 8.h),
        SizedBox(
          height: 180.h,
          child: CPGameCard(
            game: _sampleGame,
            onOpen: () {},
          ),
        ),
        SizedBox(height: 14.h),
        Text(context.l10n.promoTitle1, style: CPAppTextStyles.h2),
        SizedBox(height: 8.h),
        SizedBox(
          height: 190.h,
          child: CPPromoBanner(
            imageUrl: 'https://picsum.photos/seed/widgetbook-promo/1200/600',
            title: context.l10n.promoTitle1,
            ctaLabel: context.l10n.promoCta,
          ),
        ),
      ],
    );
  }
}

class _CPColorDot extends StatelessWidget {
  const _CPColorDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 30.w,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
