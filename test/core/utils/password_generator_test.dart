import 'package:casino_platform_test/src/core/utils/password_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PasswordGenerator', () {
    test('returns password with requested length', () {
      final String value = PasswordGenerator.generate(length: 20);
      expect(value.length, equals(20));
    });

    test('generates different values across calls', () {
      final String first = PasswordGenerator.generate(length: 16);
      final String second = PasswordGenerator.generate(length: 16);
      expect(first, isNot(equals(second)));
    });
  });
}
