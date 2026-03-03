import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/widgets/app_badge.dart';
import 'package:casino_platform_test/src/shared/widgets/app_button.dart';
import 'package:casino_platform_test/src/shared/widgets/app_loading_skeleton.dart';
import 'package:casino_platform_test/src/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Internal widgetbook-like screen for reusable component and theme preview.
class WidgetbookScreen extends StatelessWidget {
  /// Route path for widgetbook screen.
  static const String routePath = RoutePaths.widgetbook;

  /// Creates [WidgetbookScreen].
  const WidgetbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController sampleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.text('widgetbookTitle'))),
      body: ListView(
        padding: EdgeInsets.all(12.w),
        children: <Widget>[
          Text(context.l10n.text('themeTokens'), style: AppTextStyles.h2),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            children: const <Widget>[
              _ColorDot(color: AppColors.primary),
              _ColorDot(color: AppColors.accent),
              _ColorDot(color: AppColors.warning),
            ],
          ),
          SizedBox(height: 14.h),
          Text(context.l10n.text('sharedWidgets'), style: AppTextStyles.h2),
          SizedBox(height: 8.h),
          AppTextField(
            controller: sampleController,
            label: context.l10n.text('sampleInput'),
          ),
          SizedBox(height: 8.h),
          AppButton(
              label: context.l10n.text('primaryButton'), onPressed: () {}),
          SizedBox(height: 8.h),
          const AppBadge(label: 'Badge'),
          SizedBox(height: 8.h),
          const AppLoadingSkeleton(height: 80),
        ],
      ),
    );
  }
}

/// Small color preview dot used in widgetbook theme tab.
class _ColorDot extends StatelessWidget {
  /// Creates [_ColorDot].
  const _ColorDot({required this.color});

  /// Dot fill color.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 30.w,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
