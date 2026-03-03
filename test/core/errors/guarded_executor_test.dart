import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/core/exceptions/exception_codes.dart';
import 'package:casino_platform_test/src/core/exceptions/guarded_executor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPGuardedExecutor', () {
    final CPGuardedExecutor executor = CPGuardedExecutor();

    test('returns action result on success', () async {
      final int result = await executor.run(() async => 7);
      expect(result, equals(7));
    });

    test('rethrows CPAppException as-is', () async {
      expect(
        () => executor.run<int>(
          () async => throw const CPValidationException(
            code: CPValidationErrorCode.emptyField,
          ),
        ),
        throwsA(isA<CPValidationException>()),
      );
    });

    test('wraps unknown errors into CPUnexpectedAppException', () async {
      expect(
        () => executor.run<int>(() async => throw Exception('boom')),
        throwsA(isA<CPUnexpectedAppException>()),
      );
    });
  });
}
