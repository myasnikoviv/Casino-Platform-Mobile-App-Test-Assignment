import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/core/errors/guarded_executor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GuardedExecutor', () {
    final GuardedExecutor executor = GuardedExecutor();

    test('returns action result on success', () async {
      final int result = await executor.run(() async => 7);
      expect(result, equals(7));
    });

    test('rethrows AppException as-is', () async {
      expect(
        () => executor.run<int>(
          () async => throw const ValidationException(code: 'emptyField'),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('wraps unknown errors into UnexpectedAppException', () async {
      expect(
        () => executor.run<int>(() async => throw Exception('boom')),
        throwsA(isA<UnexpectedAppException>()),
      );
    });
  });
}
