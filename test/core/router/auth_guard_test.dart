import 'package:casino_platform_test/src/core/router/auth_guard.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthGuard', () {
    final AuthGuard guard = AuthGuard();

    test('redirects unauthenticated user to login', () {
      final String? redirect = guard.redirect(
        status: AuthStatus.unauthenticated,
        location: RoutePaths.shell,
      );

      expect(redirect, equals(RoutePaths.login));
    });

    test('allows unauthenticated user to stay on auth screen', () {
      final String? redirect = guard.redirect(
        status: AuthStatus.unauthenticated,
        location: RoutePaths.signUp,
      );

      expect(redirect, isNull);
    });

    test('redirects authenticated user away from login', () {
      final String? redirect = guard.redirect(
        status: AuthStatus.authenticated,
        location: RoutePaths.login,
      );

      expect(redirect, equals(RoutePaths.shell));
    });

    test('blocks onboarding route for anonymous user', () {
      final String? redirect = guard.redirect(
        status: AuthStatus.unauthenticated,
        location: RoutePaths.biometricSetup,
      );

      expect(redirect, equals(RoutePaths.login));
    });
  });
}
