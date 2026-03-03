import 'package:casino_platform_test/src/core/cache/ttl_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPTtlCache', () {
    test('returns null before put', () {
      final CPTtlCache<String> cache = CPMemoryTtlCache<String>();
      expect(cache.get(), isNull);
    });

    test('returns value while ttl is valid', () {
      final CPTtlCache<String> cache = CPMemoryTtlCache<String>();
      cache.put('value', const Duration(seconds: 2));

      expect(cache.get(), equals('value'));
    });

    test('expires value after ttl', () async {
      final CPTtlCache<String> cache = CPMemoryTtlCache<String>();
      cache.put('value', const Duration(milliseconds: 10));

      await Future<void>.delayed(const Duration(milliseconds: 20));

      expect(cache.get(), isNull);
    });

    test('clear removes cached value', () {
      final CPTtlCache<int> cache = CPMemoryTtlCache<int>();
      cache.put(42, const Duration(minutes: 1));

      cache.clear();

      expect(cache.get(), isNull);
    });
  });
}
