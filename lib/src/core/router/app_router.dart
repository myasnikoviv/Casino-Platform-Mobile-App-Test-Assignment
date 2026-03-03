import 'dart:async';

import 'package:casino_platform_test/src/core/di/di.dart';
import 'package:casino_platform_test/src/core/router/auth_guard.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/biometric_setup_screen.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/login_screen.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/password_review_screen.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/sign_up_screen.dart';
import 'package:casino_platform_test/src/features/games/ui/screens/game_detail_screen.dart';
import 'package:casino_platform_test/src/features/games/ui/view_models/game_view_model.dart';
import 'package:casino_platform_test/src/features/main_shell/ui/screens/main_shell_screen.dart';
import 'package:casino_platform_test/src/features/widgetbook/ui/screens/widgetbook_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Application router configuration with auth-aware redirection policy.
abstract final class CPRouter {
  static final CPDI _di = CPDI();
  static final CPAuthGuard _authGuard = CPAuthGuard();
  static final _CPAuthRefreshListenable _refreshListenable =
      _CPAuthRefreshListenable(_di.resolveDependency<CPAuthCubit>());

  /// GoRouter instance used by [MaterialApp.router].
  static final GoRouter router = GoRouter(
    initialLocation: CPLoginScreen.routePath.fullPath,
    refreshListenable: _refreshListenable,
    redirect: _redirect,
    routes: <RouteBase>[
      GoRoute(
        path: CPLoginScreen.routePath.fullPath,
        builder: (_, __) => const CPLoginScreen(),
      ),
      GoRoute(
        path: CPSignUpScreen.routePath.fullPath,
        builder: (_, __) => const CPSignUpScreen(),
      ),
      GoRoute(
        path: CPPasswordReviewScreen.routePath.fullPath,
        builder: (_, GoRouterState state) {
          final String password =
              state.extra is String ? state.extra! as String : '';
          return CPPasswordReviewScreen(password: password);
        },
      ),
      GoRoute(
        path: CPBiometricSetupScreen.routePath.fullPath,
        builder: (_, __) => const CPBiometricSetupScreen(),
      ),
      GoRoute(
        path: CPMainShellScreen.routePath.fullPath,
        builder: (_, __) => const CPMainShellScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: CPGameDetailScreen.pathChunk,
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
                      scale: Tween<double>(begin: 0.97, end: 1).animate(curve),
                      child: child,
                    ),
                  );
                },
              );
            },
          ),
          GoRoute(
            path: CPWidgetbookScreen.pathChunk,
            builder: (_, __) => const CPWidgetbookScreen(),
          ),
        ],
      ),
    ],
  );

  static String? _redirect(BuildContext _, GoRouterState state) {
    final CPAuthState authState = _di.resolveDependency<CPAuthCubit>().state;
    if (authState is CPAuthUnknownState) {
      return null;
    }
    return _authGuard.redirect(
      state: authState,
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
