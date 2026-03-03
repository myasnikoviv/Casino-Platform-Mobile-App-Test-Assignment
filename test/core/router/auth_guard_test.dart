import 'package:casino_platform_test/src/core/router/auth_guard.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPAuthGuard', () {
    final CPAuthGuard guard = CPAuthGuard();

    test('redirects unauthenticated user to login', () {
      final String? redirect = guard.redirect(
        status: CPAuthStatus.unauthenticated,
        location: CPRoutePaths.shell,
      );

      expect(redirect, equals(CPRoutePaths.login));
    });

    test('allows unauthenticated user to stay on auth screen', () {
      final String? redirect = guard.redirect(
        status: CPAuthStatus.unauthenticated,
        location: CPRoutePaths.signUp,
      );

      expect(redirect, isNull);
    });

    test('redirects authenticated user away from login', () {
      final String? redirect = guard.redirect(
        status: CPAuthStatus.authenticated,
        location: CPRoutePaths.login,
      );

      expect(redirect, equals(CPRoutePaths.shell));
    });

    test('blocks onboarding route for anonymous user', () {
      final String? redirect = guard.redirect(
        status: CPAuthStatus.unauthenticated,
        location: CPRoutePaths.biometricSetup,
      );

      expect(redirect, equals(CPRoutePaths.login));
    });
  });
}
