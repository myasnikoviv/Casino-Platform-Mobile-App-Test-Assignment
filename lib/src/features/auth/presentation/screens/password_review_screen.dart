import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/auth/presentation/widgets/auth_screen_container.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Post sign-up checkpoint that asks user to save generated password.
class PasswordReviewScreen extends StatelessWidget {
  /// Route path for password review screen.
  static const String routePath = RoutePaths.passwordReview;

  /// Creates [PasswordReviewScreen].
  const PasswordReviewScreen({required this.password, super.key});

  /// Plaintext password shown for user copy action.
  final String password;

  void _onCopyTap(BuildContext context) {
    Clipboard.setData(ClipboardData(text: password));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.text('passwordCopied'))),
    );
  }

  void _onContinueTap(BuildContext context) {
    context.go(RoutePaths.biometricSetup);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 16.h),
          Text(context.l10n.text('passwordSavedTitle'),
              style: AppTextStyles.h1),
          SizedBox(height: 10.h),
          Text(
            context.l10n.text('passwordSavedDescription'),
            style: AppTextStyles.body,
          ),
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.black12),
            ),
            child: Text(password, style: AppTextStyles.h2),
          ),
          SizedBox(height: 12.h),
          AppButton(
            label: context.l10n.text('copyPassword'),
            onPressed: () => _onCopyTap(context),
            icon: Icons.copy,
          ),
          SizedBox(height: 12.h),
          AppButton(
            label: context.l10n.text('continueButton'),
            onPressed: () => _onContinueTap(context),
          ),
        ],
      ),
    );
  }
}
