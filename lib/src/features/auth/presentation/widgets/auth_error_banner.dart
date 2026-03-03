import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Compact warning banner for validation and domain errors.
class AuthErrorBanner extends StatelessWidget {
  /// Creates [AuthErrorBanner].
  const AuthErrorBanner({required this.message, super.key});

  /// User-facing error text.
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(message, style: AppTextStyles.body),
    );
  }
}
