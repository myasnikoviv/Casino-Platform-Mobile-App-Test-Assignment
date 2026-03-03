import 'package:casino_platform_test/src/core/utils/password_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPPasswordGenerator', () {
    test('returns password with requested length', () {
      final String value = CPPasswordGenerator.generate(length: 20);
      expect(value.length, equals(20));
    });

    test('generates different values across calls', () {
      final String first = CPPasswordGenerator.generate(length: 16);
      final String second = CPPasswordGenerator.generate(length: 16);
      expect(first, isNot(equals(second)));
    });
  });
}
