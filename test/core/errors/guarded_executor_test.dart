import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/core/exceptions/error_reporting_service.dart';
import 'package:casino_platform_test/src/core/exceptions/exception_codes.dart';
import 'package:casino_platform_test/src/core/exceptions/guarded_executor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPGuardedExecutor', () {
    late _FakeErrorReportingService errorReportingService;
    late CPGuardedExecutor executor;

    setUp(() {
      errorReportingService = _FakeErrorReportingService();
      executor = CPGuardedExecutor(errorReportingService);
    });

    test('returns action result on success', () async {
      final int result = await executor.run(() async => 7);
      expect(result, equals(7));
      expect(errorReportingService.calls, equals(0));
    });

    test('rethrows CPAppException as-is', () async {
      await expectLater(
        executor.run<int>(
          () async => throw const CPValidationException(
            code: CPValidationErrorCode.emptyField,
          ),
        ),
        throwsA(isA<CPValidationException>()),
      );
      expect(errorReportingService.calls, equals(1));
    });

    test('wraps unknown errors into CPUnexpectedAppException', () async {
      await expectLater(
        executor.run<int>(() async => throw Exception('boom')),
        throwsA(isA<CPUnexpectedAppException>()),
      );
      expect(errorReportingService.calls, equals(1));
    });

    test('ignores reporting service failure and still throws mapped error',
        () async {
      errorReportingService.shouldThrow = true;

      await expectLater(
        executor.run<int>(() async => throw Exception('boom')),
        throwsA(isA<CPUnexpectedAppException>()),
      );
      expect(errorReportingService.calls, equals(1));
    });
  });
}

class _FakeErrorReportingService implements CPErrorReportingService {
  int calls = 0;
  bool shouldThrow = false;

  @override
  Future<void> captureException(
    Object error,
    StackTrace stackTrace, {
    Map<String, Object?>? context,
  }) async {
    calls++;
    if (shouldThrow) {
      throw StateError('Reporter failed');
    }
  }
}
