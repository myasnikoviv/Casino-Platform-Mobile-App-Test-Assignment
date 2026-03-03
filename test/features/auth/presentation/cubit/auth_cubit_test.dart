import 'package:bloc_test/bloc_test.dart';
import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/core/errors/guarded_executor.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fake_auth_service.dart';
import '../../../../helpers/test_session.dart';

void main() {
  group('AuthCubit', () {
    blocTest<AuthCubit, AuthState>(
      'initialize emits authenticated when session exists',
      build: () => AuthCubit(
        FakeAuthService(
          canUseBiometricsResult: true,
          restoreResult: testSession,
        ),
        GuardedExecutor(),
      ),
      act: (AuthCubit cubit) => cubit.initialize(),
      expect: () => <Matcher>[
        isA<AuthState>().having((AuthState s) => s.isBusy, 'isBusy', true),
        isA<AuthState>()
            .having(
                (AuthState s) => s.status, 'status', AuthStatus.authenticated)
            .having((AuthState s) => s.session, 'session', testSession)
            .having((AuthState s) => s.biometricsAvailable, 'bio', true),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'login emits authenticated on success',
      build: () => AuthCubit(
        FakeAuthService(loginResult: testSession),
        GuardedExecutor(),
      ),
      act: (AuthCubit cubit) => cubit.login('alex@example.com', 'Password123!'),
      expect: () => <Matcher>[
        isA<AuthState>().having((AuthState s) => s.isBusy, 'isBusy', true),
        isA<AuthState>()
            .having(
                (AuthState s) => s.status, 'status', AuthStatus.authenticated)
            .having((AuthState s) => s.session, 'session', testSession),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'login emits error when auth fails',
      build: () => AuthCubit(
        FakeAuthService(
            loginError: const AuthException(code: 'invalidCredentials')),
        GuardedExecutor(),
      ),
      act: (AuthCubit cubit) => cubit.login('alex@example.com', 'bad'),
      expect: () => <Matcher>[
        isA<AuthState>().having((AuthState s) => s.isBusy, 'isBusy', true),
        isA<AuthState>()
            .having((AuthState s) => s.isBusy, 'isBusy', false)
            .having((AuthState s) => s.error, 'error', isA<AuthException>()),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'logout emits unauthenticated state',
      build: () {
        final AuthCubit cubit = AuthCubit(
          FakeAuthService(loginResult: testSession),
          GuardedExecutor(),
        );
        return cubit;
      },
      seed: () => const AuthState(
        status: AuthStatus.authenticated,
        session: testSession,
      ),
      act: (AuthCubit cubit) => cubit.logout(),
      expect: () => <Matcher>[
        isA<AuthState>().having((AuthState s) => s.isBusy, 'isBusy', true),
        isA<AuthState>()
            .having(
                (AuthState s) => s.status, 'status', AuthStatus.unauthenticated)
            .having((AuthState s) => s.session, 'session', isNull),
      ],
    );
  });
}
