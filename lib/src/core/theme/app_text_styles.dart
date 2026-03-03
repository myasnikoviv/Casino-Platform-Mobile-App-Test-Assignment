import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Typography tokens centralized for reuse and consistency.
abstract final class CPAppTextStyles {
  /// Large heading style for major screen titles.
  static TextStyle h1 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    color: CPAppColors.textPrimary,
    height: 1.2,
  );

  /// Medium heading style for section titles.
  static TextStyle h2 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: CPAppColors.textPrimary,
    height: 1.25,
  );

  /// Body style for standard content.
  static TextStyle body = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: CPAppColors.textPrimary,
    height: 1.4,
  );

  /// Small label style for metadata and badges.
  static TextStyle label = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: CPAppColors.textSecondary,
    height: 1.3,
  );
}
