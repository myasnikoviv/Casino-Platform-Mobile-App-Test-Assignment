import 'dart:async';

import 'package:casino_platform_test/src/core/router/auth_guard.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/auth/screens/biometric_setup_screen.dart';
import 'package:casino_platform_test/src/features/auth/screens/login_screen.dart';
import 'package:casino_platform_test/src/features/auth/screens/password_review_screen.dart';
import 'package:casino_platform_test/src/features/auth/screens/sign_up_screen.dart';
import 'package:casino_platform_test/src/features/games/entities/game_view_model.dart';
import 'package:casino_platform_test/src/features/games/screens/game_detail_screen.dart';
import 'package:casino_platform_test/src/features/main_shell/screens/main_shell_screen.dart';
import 'package:casino_platform_test/src/features/widgetbook/screens/widgetbook_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Application router configuration with auth-aware redirection policy.
class CPRouter {
  /// Creates [CPRouter].
  CPRouter(CPAuthCubit authCubit)
      : _authCubit = authCubit,
        _authGuard = CPAuthGuard(),
        _refreshListenable = _CPAuthRefreshListenable(authCubit) {
    router = GoRouter(
      initialLocation: CPRoutePaths.login,
      refreshListenable: _refreshListenable,
      redirect: _redirect,
      routes: <RouteBase>[
        GoRoute(
          path: CPLoginScreen.routePath,
          builder: (_, __) => const CPLoginScreen(),
        ),
        GoRoute(
          path: CPSignUpScreen.routePath,
          builder: (_, __) => const CPSignUpScreen(),
        ),
        GoRoute(
          path: CPPasswordReviewScreen.routePath,
          builder: (_, GoRouterState state) {
            final String password =
                state.extra is String ? state.extra! as String : '';
            return CPPasswordReviewScreen(password: password);
          },
        ),
        GoRoute(
          path: CPBiometricSetupScreen.routePath,
          builder: (_, __) => const CPBiometricSetupScreen(),
        ),
        GoRoute(
          path: CPMainShellScreen.routePath,
          builder: (_, __) => const CPMainShellScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: 'game/:gameId',
              pageBuilder: (_, GoRouterState state) {
                final String gameId = state.pathParameters['gameId'] ?? '';
                final CPGameViewModel? extra = state.extra as CPGameViewModel?;
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: CPGameDetailScreen(gameId: gameId, extra: extra),
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    final CurvedAnimation curve = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    );
                    return FadeTransition(
                      opacity: curve,
                      child: ScaleTransition(
                        scale:
                            Tween<double>(begin: 0.97, end: 1).animate(curve),
                        child: child,
                      ),
                    );
                  },
                );
              },
            ),
            GoRoute(
              path: 'profile/widgetbook',
              builder: (_, __) => const CPWidgetbookScreen(),
            ),
          ],
        ),
      ],
    );
  }

  final CPAuthCubit _authCubit;
  final CPAuthGuard _authGuard;
  final _CPAuthRefreshListenable _refreshListenable;

  /// GoRouter instance used by MaterialApp.router.
  late final GoRouter router;

  String? _redirect(BuildContext _, GoRouterState state) {
    if (_authCubit.state.status == CPAuthStatus.unknown) {
      return null;
    }
    return _authGuard.redirect(
      status: _authCubit.state.status,
      location: state.uri.path,
    );
  }
}

class _CPAuthRefreshListenable extends ChangeNotifier {
  _CPAuthRefreshListenable(CPAuthCubit authCubit) {
    _subscription = authCubit.stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<CPAuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
