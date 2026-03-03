import 'dart:async';

import 'package:casino_platform_test/src/core/di/service_locator.dart';
import 'package:casino_platform_test/src/core/router/auth_guard.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/auth/presentation/screens/biometric_setup_screen.dart';
import 'package:casino_platform_test/src/features/auth/presentation/screens/login_screen.dart';
import 'package:casino_platform_test/src/features/auth/presentation/screens/password_review_screen.dart';
import 'package:casino_platform_test/src/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:casino_platform_test/src/features/games/domain/entities/game_view_model.dart';
import 'package:casino_platform_test/src/features/games/presentation/screens/game_detail_screen.dart';
import 'package:casino_platform_test/src/features/main_shell/presentation/screens/main_shell_screen.dart';
import 'package:casino_platform_test/src/features/widgetbook/presentation/screens/widgetbook_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Application router configuration with auth-aware redirection policy.
class AppRouter {
  /// Creates [AppRouter].
  AppRouter(ServiceLocator locator)
      : _authCubit = locator.authCubit,
        _authGuard = AuthGuard(),
        _refreshListenable = _AuthRefreshListenable(locator.authCubit) {
    router = GoRouter(
      initialLocation: RoutePaths.login,
      refreshListenable: _refreshListenable,
      redirect: _redirect,
      routes: <RouteBase>[
        GoRoute(
          path: LoginScreen.routePath,
          builder: (_, __) => const LoginScreen(),
        ),
        GoRoute(
          path: SignUpScreen.routePath,
          builder: (_, __) => const SignUpScreen(),
        ),
        GoRoute(
          path: PasswordReviewScreen.routePath,
          builder: (_, GoRouterState state) {
            final String password =
                state.extra is String ? state.extra! as String : '';
            return PasswordReviewScreen(password: password);
          },
        ),
        GoRoute(
          path: BiometricSetupScreen.routePath,
          builder: (_, __) => const BiometricSetupScreen(),
        ),
        GoRoute(
          path: MainShellScreen.routePath,
          builder: (_, __) => const MainShellScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: 'game/:gameId',
              pageBuilder: (_, GoRouterState state) {
                final String gameId = state.pathParameters['gameId'] ?? '';
                final GameViewModel? extra = state.extra as GameViewModel?;
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: GameDetailScreen(gameId: gameId, extra: extra),
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
              builder: (_, __) => const WidgetbookScreen(),
            ),
          ],
        ),
      ],
    );
  }

  final AuthCubit _authCubit;
  final AuthGuard _authGuard;
  final _AuthRefreshListenable _refreshListenable;

  /// GoRouter instance used by MaterialApp.router.
  late final GoRouter router;

  String? _redirect(BuildContext _, GoRouterState state) {
    if (_authCubit.state.status == AuthStatus.unknown) {
      return null;
    }
    return _authGuard.redirect(
      status: _authCubit.state.status,
      location: state.uri.path,
    );
  }
}

class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable(AuthCubit authCubit) {
    _subscription = authCubit.stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
