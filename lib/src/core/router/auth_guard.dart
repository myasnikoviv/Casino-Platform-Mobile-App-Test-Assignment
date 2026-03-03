import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_state.dart';

/// Central auth guard policy for route redirections.
class AuthGuard {
  /// Returns redirect path or null if navigation is allowed.
  String? redirect({
    required AuthStatus status,
    required String location,
  }) {
    final bool isAuthRoute =
        location == RoutePaths.login || location == RoutePaths.signUp;
    final bool isOnboardingRoute = location == RoutePaths.passwordReview ||
        location == RoutePaths.biometricSetup;

    if (status == AuthStatus.unauthenticated && !isAuthRoute) {
      return RoutePaths.login;
    }

    if (status == AuthStatus.authenticated && isAuthRoute) {
      return RoutePaths.shell;
    }

    if (status == AuthStatus.unauthenticated && isOnboardingRoute) {
      return RoutePaths.login;
    }

    return null;
  }
}
