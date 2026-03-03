import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/main_shell/ui/screens/main_shell_screen.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/app_badge.dart';
import 'package:casino_platform_test/src/shared/ui/app_button.dart';
import 'package:casino_platform_test/src/shared/ui/app_loading_skeleton.dart';
import 'package:casino_platform_test/src/shared/ui/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Internal widgetbook-like screen for reusable component and theme preview.
class CPWidgetBookScreen extends StatelessWidget {
  /// Route chunk for widgetbook screen.
  static const String pathChunk = 'profile/widgetbook';

  /// Route path for widgetbook screen.
  static final CPRoutePath routePath = CPRoutePath(
    CPMainShellScreen.routePath.fullPath,
    <String>[pathChunk],
  );

  /// Creates [CPWidgetBookScreen].
  const CPWidgetBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController sampleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.widgetbookTitle)),
      body: ListView(
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
          Text(context.l10n.sharedWidgets, style: CPAppTextStyles.h2),
          SizedBox(height: 8.h),
          CPAppTextField(
            controller: sampleController,
            label: context.l10n.sampleInput,
          ),
          SizedBox(height: 8.h),
          CPAppButton(label: context.l10n.primaryButton, onPressed: () {}),
          SizedBox(height: 8.h),
          const CPAppBadge(label: 'Badge'),
          SizedBox(height: 8.h),
          CPAppLoadingSkeleton(height: 80.h),
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
