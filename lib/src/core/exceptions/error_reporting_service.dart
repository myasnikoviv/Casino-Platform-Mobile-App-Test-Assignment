/// Contract for sending error telemetry to third-party monitoring providers.
abstract interface class CPErrorReportingService {
  /// Sends [error] and [stackTrace] to external error tracking.
  Future<void> captureException(
    Object error,
    StackTrace stackTrace, {
    Map<String, Object?>? context,
  });
}

/// No-op implementation used until real provider integration is enabled.
class CPNoopErrorReportingService implements CPErrorReportingService {
  /// Creates [CPNoopErrorReportingService].
  const CPNoopErrorReportingService();

  @override
  Future<void> captureException(
    Object error,
    StackTrace stackTrace, {
    Map<String, Object?>? context,
  }) async {}
}
