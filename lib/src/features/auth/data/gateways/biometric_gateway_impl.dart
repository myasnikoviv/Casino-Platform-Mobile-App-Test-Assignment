import 'package:casino_platform_test/src/core/constants/app_constants.dart';
import 'package:casino_platform_test/src/core/storage/secure_storage_service.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/biometric_gateway.dart';

/// Secure-storage backed biometric mapping gateway.
class CPBiometricGatewayImpl implements CPBiometricGateway {
  /// Creates [CPBiometricGatewayImpl].
  const CPBiometricGatewayImpl(this._secureStorageService);

  final CPSecureStorageService _secureStorageService;

  @override
  Future<void> saveBiometricIdentifier(String identifier) {
    return _secureStorageService.write(
        CPAppConstants.biometricEmailKey, identifier);
  }

  @override
  Future<String?> getBiometricIdentifier() {
    return _secureStorageService.read(CPAppConstants.biometricEmailKey);
  }

  @override
  Future<void> clearBiometricIdentifier() {
    return _secureStorageService.delete(CPAppConstants.biometricEmailKey);
  }
}
