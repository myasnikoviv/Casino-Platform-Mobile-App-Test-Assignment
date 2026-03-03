/// Contract for biometric login mapping persistence.
abstract interface class CPBiometricGateway {
  /// Stores biometric login identifier for current account.
  Future<void> saveBiometricIdentifier(String identifier);

  /// Returns stored biometric login identifier if configured.
  Future<String?> getBiometricIdentifier();

  /// Clears stored biometric login identifier.
  Future<void> clearBiometricIdentifier();
}
