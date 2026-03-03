import 'package:casino_platform_test/src/core/storage/secure_storage_service.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/biometric_gateway.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/biometric_gateway_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CPBiometricGatewayImpl', () {
    late CPBiometricGateway gateway;

    setUp(() {
      gateway = CPBiometricGatewayImpl(_CPFakeSecureStorageService());
    });

    test('stores and restores biometric identifier', () async {
      await gateway.saveBiometricIdentifier('jane@example.com');
      final String? value = await gateway.getBiometricIdentifier();

      expect(value, equals('jane@example.com'));
    });

    test('clears biometric identifier', () async {
      await gateway.saveBiometricIdentifier('jane@example.com');
      await gateway.clearBiometricIdentifier();

      final String? value = await gateway.getBiometricIdentifier();
      expect(value, isNull);
    });
  });
}

class _CPFakeSecureStorageService implements CPSecureStorageService {
  final Map<String, String> _storage = <String, String>{};

  @override
  Future<void> delete(String key) async {
    _storage.remove(key);
  }

  @override
  Future<String?> read(String key) async {
    return _storage[key];
  }

  @override
  Future<void> write(String key, String value) async {
    _storage[key] = value;
  }
}
