import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
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
  late final TextEditingController _sampleController;

  @override
  void initState() {
    super.initState();
    _sampleController = TextEditingController();
  }

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
