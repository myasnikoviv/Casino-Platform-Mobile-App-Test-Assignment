import 'package:casino_platform_test/src/core/errors/app_exception.dart';

/// Centralized try/catch wrapper to keep error handling consistent.
class CPGuardedExecutor {
  /// Executes [action] and converts unknown failures to [CPUnexpectedAppException].
  Future<T> run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on CPAppException {
      rethrow;
    } catch (error) {
      throw CPUnexpectedAppException(message: error.toString());
    }
  }
}
