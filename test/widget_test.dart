import 'package:casino_platform_test/src/core/utils/hash_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('hash utility should produce deterministic sha256', () {
    final String value = CPHashUtils.sha256Of('password123');
    expect(
      value,
      equals(
          'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f'),
    );
  });
}
