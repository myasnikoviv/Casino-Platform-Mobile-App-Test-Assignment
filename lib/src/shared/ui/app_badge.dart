import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Small badge component used for category/metadata labels.
class CPAppBadge extends StatelessWidget {
  /// Creates [CPAppBadge].
  const CPAppBadge({required this.label, super.key});

  /// Badge text content.
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: CPAppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        label,
        style: CPAppTextStyles.label.copyWith(color: CPAppColors.primary),
      ),
    );
  }
}
