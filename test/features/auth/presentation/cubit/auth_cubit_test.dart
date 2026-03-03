import 'package:bloc_test/bloc_test.dart';
import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/core/errors/guarded_executor.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fake_auth_service.dart';
import '../../../../helpers/test_session.dart';

void main() {
  group('CPAuthCubit', () {
    blocTest<CPAuthCubit, CPAuthState>(
      'initialize emits authenticated when session exists',
      build: () => CPAuthCubit(
        CPFakeAuthService(
          canUseBiometricsResult: true,
          restoreResult: testSession,
        ),
        CPGuardedExecutor(),
      ),
      act: (CPAuthCubit cubit) => cubit.initialize(),
      expect: () => <Matcher>[
        isA<CPAuthUnknownState>().having((s) => s.isBusy, 'isBusy', true),
        isA<CPAuthenticatedState>()
            .having((s) => s.session, 'session', testSession)
            .having((s) => s.biometricsAvailable, 'bio', true),
      ],
    );

    blocTest<CPAuthCubit, CPAuthState>(
      'login emits authenticated on success',
      build: () => CPAuthCubit(
        CPFakeAuthService(loginResult: testSession),
        CPGuardedExecutor(),
      ),
      act: (CPAuthCubit cubit) =>
          cubit.login('alex@example.com', 'Password123!'),
      expect: () => <Matcher>[
        isA<CPUnauthenticatedState>().having((s) => s.isBusy, 'isBusy', true),
        isA<CPAuthenticatedState>()
            .having((s) => s.session, 'session', testSession),
      ],
    );

    blocTest<CPAuthCubit, CPAuthState>(
      'login emits error when auth fails',
      build: () => CPAuthCubit(
        CPFakeAuthService(
          loginError: const CPAuthException(code: 'invalidCredentials'),
        ),
        CPGuardedExecutor(),
      ),
      act: (CPAuthCubit cubit) => cubit.login('alex@example.com', 'bad'),
      expect: () => <Matcher>[
        isA<CPUnauthenticatedState>().having((s) => s.isBusy, 'isBusy', true),
        isA<CPUnauthenticatedState>()
            .having((s) => s.error, 'error', isA<CPAuthException>()),
      ],
    );

    blocTest<CPAuthCubit, CPAuthState>(
      'logout emits unauthenticated state',
      build: () => CPAuthCubit(
        CPFakeAuthService(loginResult: testSession),
        CPGuardedExecutor(),
      ),
      seed: () => const CPAuthenticatedState(session: testSession),
      act: (CPAuthCubit cubit) => cubit.logout(),
      expect: () => <Matcher>[
        isA<CPUnauthenticatedState>().having((s) => s.isBusy, 'isBusy', true),
        isA<CPUnauthenticatedState>(),
      ],
    );
  });
}
