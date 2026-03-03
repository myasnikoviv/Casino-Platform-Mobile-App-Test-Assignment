import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Compact warning banner for validation and domain errors.
class CPAuthErrorBanner extends StatelessWidget {
  /// Creates [CPAuthErrorBanner].
  const CPAuthErrorBanner({required this.messages, super.key});

  /// User-facing error texts.
  final List<String> messages;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: CPAppColors.warning.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: messages
            .map(
              (String message) => Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Text('• $message', style: CPAppTextStyles.body),
              ),
            )
            .toList(),
      ),
    );
  }
}
