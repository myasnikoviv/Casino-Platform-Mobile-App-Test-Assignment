import 'package:casino_platform_test/src/core/router/auth_guard.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/biometric_setup_screen.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/login_screen.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/sign_up_screen.dart';
import 'package:casino_platform_test/src/features/main_shell/ui/screens/main_shell_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/test_session.dart';

void main() {
  group('CPAuthGuard', () {
    final CPAuthGuard guard = CPAuthGuard();

    test('redirects unauthenticated user to login', () {
      final String? redirect = guard.redirect(
        state: const CPUnauthenticatedState(),
        location: CPMainShellScreen.routePath.fullPath,
      );

      expect(redirect, equals(CPLoginScreen.routePath.fullPath));
    });

    test('allows unauthenticated user to stay on auth screen', () {
      final String? redirect = guard.redirect(
        state: const CPUnauthenticatedState(),
        location: CPSignUpScreen.routePath.fullPath,
      );

      expect(redirect, isNull);
    });

    test('redirects authenticated user away from login', () {
      final String? redirect = guard.redirect(
        state: const CPAuthenticatedState(session: testSession),
        location: CPLoginScreen.routePath.fullPath,
      );

      expect(redirect, equals(CPMainShellScreen.routePath.fullPath));
    });

    test('blocks onboarding route for anonymous user', () {
      final String? redirect = guard.redirect(
        state: const CPUnauthenticatedState(),
        location: CPBiometricSetupScreen.routePath.fullPath,
      );

      expect(redirect, equals(CPLoginScreen.routePath.fullPath));
    });
  });
}
