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
class CPWidgetbookScreen extends StatelessWidget {
  /// Route path for widgetbook screen.
  static const String routePath = CPRoutePaths.widgetbook;

  /// Creates [CPWidgetbookScreen].
  const CPWidgetbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController sampleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.text('widgetbookTitle'))),
      body: ListView(
        padding: EdgeInsets.all(12.w),
        children: <Widget>[
          Text(context.l10n.text('themeTokens'), style: CPAppTextStyles.h2),
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
          Text(context.l10n.text('sharedWidgets'), style: CPAppTextStyles.h2),
          SizedBox(height: 8.h),
          CPAppTextField(
            controller: sampleController,
            label: context.l10n.text('sampleInput'),
          ),
          SizedBox(height: 8.h),
          CPAppButton(
              label: context.l10n.text('primaryButton'), onPressed: () {}),
          SizedBox(height: 8.h),
          const CPAppBadge(label: 'Badge'),
          SizedBox(height: 8.h),
          const CPAppLoadingSkeleton(height: 80),
        ],
      ),
    );
  }
}

/// Small color preview dot used in widgetbook theme tab.
class _CPColorDot extends StatelessWidget {
  /// Creates [_CPColorDot].
  const _CPColorDot({required this.color});

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
