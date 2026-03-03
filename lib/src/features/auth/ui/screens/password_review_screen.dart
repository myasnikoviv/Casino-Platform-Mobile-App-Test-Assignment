import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/auth_screen_container.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/biometric_setup_screen.dart';
import 'package:casino_platform_test/src/features/auth/ui/views/password_review_view.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Password review screen shell.
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
      child: CPPasswordReviewView(
        title: context.l10n.passwordSavedTitle,
        description: context.l10n.passwordSavedDescription,
        password: password,
        copyLabel: context.l10n.copyPassword,
        continueLabel: context.l10n.continueButton,
        onCopyTap: () => _onCopyTap(context),
        onContinueTap: () => _onContinueTap(context),
      ),
    );
  }
}
