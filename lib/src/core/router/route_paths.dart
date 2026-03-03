/// Structured route path builder with root path and chunks.
class CPRoutePath {
  /// Creates [CPRoutePath].
  const CPRoutePath(this.rootPath, [this.chunks = const <String>[]]);

  /// Root route path (e.g. `/auth`).
  final String rootPath;

  /// Nested chunks appended to [rootPath].
  final List<String> chunks;

  /// Fully resolved path.
  String get fullPath {
    if (chunks.isEmpty) {
      return rootPath;
    }
    return <String>[rootPath, ...chunks].join('/');
  }
}

/// Centralized root path constants.
abstract final class CPRoutePaths {
  /// Auth root route.
  static const String authRoot = '/auth';

  /// Main shell root route.
  static const String mainRoot = '/main';
}
