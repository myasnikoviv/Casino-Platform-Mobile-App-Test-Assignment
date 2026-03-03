import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/core/exceptions/error_reporting_service.dart';

/// Centralized try/catch wrapper to keep error handling consistent.
class CPGuardedExecutor {
  /// Creates [CPGuardedExecutor].
  const CPGuardedExecutor(this._errorReportingService);

  final CPErrorReportingService _errorReportingService;

  /// Executes [action] and converts unknown failures to [CPUnexpectedAppException].
  Future<T> run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on CPAppException catch (error, stackTrace) {
      await _reportError(error, stackTrace);
      rethrow;
    } catch (error, stackTrace) {
      await _reportError(error, stackTrace);
      throw CPUnexpectedAppException(message: error.toString());
    }
  }

  Future<void> _reportError(Object error, StackTrace stackTrace) async {
    try {
      await _errorReportingService.captureException(error, stackTrace);
    } catch (_) {
      // Reporting failures must never break business flow.
    }
  }
}
