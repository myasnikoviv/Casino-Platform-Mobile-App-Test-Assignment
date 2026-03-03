import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/shared/ui/app_button.dart';
import 'package:casino_platform_test/src/shared/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Password review view.
class CPPasswordReviewView extends StatelessWidget {
  /// Creates [CPPasswordReviewView].
  const CPPasswordReviewView({
    required this.title,
    required this.description,
    required this.password,
    required this.copyLabel,
    required this.continueLabel,
    required this.onCopyTap,
    required this.onContinueTap,
    super.key,
  });

  final String title;
  final String description;
  final String password;
  final String copyLabel;
  final String continueLabel;
  final VoidCallback onCopyTap;
  final VoidCallback onContinueTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 16.h),
        Text(title, style: CPAppTextStyles.h1),
        SizedBox(height: 10.h),
        Text(description, style: CPAppTextStyles.body),
        SizedBox(height: 20.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.black12),
          ),
          child: Text(password, style: CPAppTextStyles.h2),
        ),
        SizedBox(height: 12.h),
        CPAppButton(
          label: copyLabel,
          onPressed: onCopyTap,
          icon: CPIconType.copy,
        ),
        SizedBox(height: 12.h),
        CPAppButton(
          label: continueLabel,
          onPressed: onContinueTap,
        ),
      ],
    );
  }
}
