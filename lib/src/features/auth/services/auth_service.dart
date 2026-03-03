import 'package:casino_platform_test/src/features/auth/entities/user_session.dart';

/// Auth service contract for business operations.
abstract interface class CPAuthService {
  /// Registers local account and starts session.
  Future<CPUserSession> register({
    required String fullName,
    required String email,
    required String password,
  });

  /// Logins existing account.
  Future<CPUserSession> login({
    required String email,
    required String password,
  });

  /// Loads active session if available.
  Future<CPUserSession?> restoreSession();

  /// Clears active session.
  Future<void> logout();

  /// Returns true when device supports biometrics.
  Future<bool> canUseBiometrics();

  /// Enables biometric quick login for current session.
  Future<void> enableBiometricForCurrentSession();

  /// Disables biometric quick login for current session.
  Future<void> disableBiometricForCurrentSession();

  /// Returns true when any biometric login is configured on device.
  Future<bool> hasBiometricLoginConfigured();

  /// Returns true when current authenticated session has biometrics enabled.
  Future<bool> isBiometricEnabledForCurrentSession();

  /// Tries biometric login and returns session when successful.
  Future<CPUserSession?> loginWithBiometrics();
}
