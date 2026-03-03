import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/shared/ui/app_button.dart';
import 'package:casino_platform_test/src/shared/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Friendly error state with retry action.
class CPAppErrorState extends StatelessWidget {
  /// Creates [CPAppErrorState].
  const CPAppErrorState({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
    super.key,
  });

  /// User-facing error message.
  final String message;

  /// Retry action title.
  final String retryLabel;

  /// Retry callback.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: CPAppColors.warning.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CPIcon(
            type: CPIconType.warning,
            color: CPAppColors.warning,
            size: 28,
          ),
          SizedBox(height: 8.h),
          Text(message,
              style: CPAppTextStyles.body, textAlign: TextAlign.center),
          SizedBox(height: 12.h),
          CPAppButton(label: retryLabel, onPressed: onRetry),
        ],
      ),
    );
  }
}
