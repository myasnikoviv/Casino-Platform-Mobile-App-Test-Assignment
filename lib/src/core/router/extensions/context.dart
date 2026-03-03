import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Router extension to keep navigation calls centralized and consistent.
extension CPRouterContextExt on BuildContext {
  /// Pushes route on top of the stack.
  Future<T?> pushRoute<T>(String path, {Object? extra}) {
    return GoRouter.of(this).push<T>(path, extra: extra);
  }

  /// Replaces current location with sub route.
  void goSubRoute(String path, {Object? extra}) {
    GoRouter.of(this).go(path, extra: extra);
  }
}
