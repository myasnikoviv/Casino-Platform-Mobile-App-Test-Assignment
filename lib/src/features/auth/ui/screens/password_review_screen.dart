import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/auth_screen_container.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/biometric_setup_screen.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/app_button.dart';
import 'package:casino_platform_test/src/shared/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Post sign-up checkpoint that asks user to save generated password.
class CPPasswordReviewScreen extends StatelessWidget {
  /// Route chunk for password review screen.
  static const String pathChunk = 'password-review';

  /// Route path for password review screen.
  static const CPRoutePath routePath = CPRoutePath(
    CPRoutePaths.authRoot,
    <String>[pathChunk],
  );

  /// Creates [CPPasswordReviewScreen].
  const CPPasswordReviewScreen({required this.password, super.key});

  /// Plaintext password shown for user copy action.
  final String password;

  void _onCopyTap(BuildContext context) {
    Clipboard.setData(ClipboardData(text: password));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.passwordCopied)),
    );
  }

  void _onContinueTap(BuildContext context) {
    context.goSubRoute(CPBiometricSetupScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return CPAuthScreenContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 16.h),
          Text(context.l10n.passwordSavedTitle, style: CPAppTextStyles.h1),
          SizedBox(height: 10.h),
          Text(
            context.l10n.passwordSavedDescription,
            style: CPAppTextStyles.body,
          ),
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
            label: context.l10n.copyPassword,
            onPressed: () => _onCopyTap(context),
            icon: CPIcons.copy,
          ),
          SizedBox(height: 12.h),
          CPAppButton(
            label: context.l10n.continueButton,
            onPressed: () => _onContinueTap(context),
          ),
        ],
      ),
    );
  }
}
