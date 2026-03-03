import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/biometric_setup_screen.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/login_screen.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/password_review_screen.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/sign_up_screen.dart';
import 'package:casino_platform_test/src/features/main_shell/ui/screens/main_shell_screen.dart';

/// Central auth guard policy for route redirections.
class CPAuthGuard {
  /// Returns redirect path or null if navigation is allowed.
  String? redirect({
    required CPAuthState state,
    required String location,
  }) {
    final bool isAuthRoute = location == CPLoginScreen.routePath.fullPath ||
        location == CPSignUpScreen.routePath.fullPath;
    final bool isOnboardingRoute =
        location == CPPasswordReviewScreen.routePath.fullPath ||
            location == CPBiometricSetupScreen.routePath.fullPath;

    if (state is CPUnauthenticatedState && !isAuthRoute) {
      return CPLoginScreen.routePath.fullPath;
    }

    if (state is CPAuthenticatedState && isAuthRoute) {
      return CPMainShellScreen.routePath.fullPath;
    }

    if (state is CPUnauthenticatedState && isOnboardingRoute) {
      return CPLoginScreen.routePath.fullPath;
    }

    return null;
  }
}
