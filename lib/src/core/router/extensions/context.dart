import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Router extension to keep navigation calls centralized and consistent.
extension CPRouterContextExt on BuildContext {
  /// Pushes route on top of the stack.
  Future<T?> pushRoute<T>(CPRoutePath path, {Object? extra}) {
    return GoRouter.of(this).push<T>(path.fullPath, extra: extra);
  }

  /// Pushes route built from root path and nested chunks.
  Future<T?> pushSubRoute<T>(
    String rootPath,
    List<String> chunks, {
    Object? extra,
  }) {
    return pushRoute<T>(CPRoutePath(rootPath, chunks), extra: extra);
  }

  /// Replaces current location with sub route.
  void goSubRoute(CPRoutePath path, {Object? extra}) {
    GoRouter.of(this).go(path.fullPath, extra: extra);
  }

  /// Replaces current location using root path and nested chunks.
  void goSubRouteByChunks(
    String rootPath,
    List<String> chunks, {
    Object? extra,
  }) {
    goSubRoute(CPRoutePath(rootPath, chunks), extra: extra);
  }
}
