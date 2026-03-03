import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App-wide primary button component.
class AppButton extends StatelessWidget {
  /// Creates [AppButton].
  const AppButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    super.key,
  });

  /// Text displayed on the button.
  final String label;

  /// Callback executed on tap.
  final VoidCallback? onPressed;

  /// Loading state for async actions.
  final bool isLoading;

  /// Optional leading icon.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (icon != null) Icon(icon, size: 18.sp),
                  if (icon != null) SizedBox(width: 8.w),
                  Text(label,
                      style: AppTextStyles.body.copyWith(color: Colors.white)),
                ],
              ),
      ),
    );
  }
}
