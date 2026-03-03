import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';

/// Central auth guard policy for route redirections.
class CPAuthGuard {
  /// Returns redirect path or null if navigation is allowed.
  String? redirect({
    required CPAuthStatus status,
    required String location,
  }) {
    final bool isAuthRoute =
        location == CPRoutePaths.login || location == CPRoutePaths.signUp;
    final bool isOnboardingRoute = location == CPRoutePaths.passwordReview ||
        location == CPRoutePaths.biometricSetup;

    if (status == CPAuthStatus.unauthenticated && !isAuthRoute) {
      return CPRoutePaths.login;
    }

    if (status == CPAuthStatus.authenticated && isAuthRoute) {
      return CPRoutePaths.shell;
    }

    if (status == CPAuthStatus.unauthenticated && isOnboardingRoute) {
      return CPRoutePaths.login;
    }

    return null;
  }
}
