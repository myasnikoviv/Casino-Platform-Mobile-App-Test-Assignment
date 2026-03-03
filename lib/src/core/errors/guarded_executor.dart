import 'package:casino_platform_test/src/core/errors/app_exception.dart';

/// Centralized try/catch wrapper to keep error handling consistent.
class GuardedExecutor {
  /// Executes [action] and converts unknown failures to [UnexpectedAppException].
  Future<T> run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AppException {
      rethrow;
    } catch (error) {
      throw UnexpectedAppException(message: error.toString());
    }
  }
}
