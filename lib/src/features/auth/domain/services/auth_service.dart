import 'package:casino_platform_test/src/features/auth/domain/entities/user_session.dart';

/// Auth service contract for business operations.
abstract interface class AuthService {
  /// Registers local account and starts session.
  Future<UserSession> register({
    required String fullName,
    required String email,
    required String password,
  });

  /// Logins existing account.
  Future<UserSession> login({
    required String email,
    required String password,
  });

  /// Loads active session if available.
  Future<UserSession?> restoreSession();

  /// Clears active session.
  Future<void> logout();

  /// Returns true when device supports biometrics.
  Future<bool> canUseBiometrics();

  /// Enables biometric quick login for current session.
  Future<void> enableBiometricForCurrentSession();

  /// Tries biometric login and returns session when successful.
  Future<UserSession?> loginWithBiometrics();
}
