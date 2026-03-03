import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable title + subtitle block for auth screens.
class AuthTitleBlock extends StatelessWidget {
  /// Creates [AuthTitleBlock].
  const AuthTitleBlock({
    required this.title,
    required this.subtitle,
    super.key,
  });

  /// Primary heading.
  final String title;

  /// Secondary supporting text.
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: AppTextStyles.h1),
        SizedBox(height: 6.h),
        Text(subtitle, style: AppTextStyles.body),
      ],
    );
  }
}
