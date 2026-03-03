import 'package:casino_platform_test/src/features/auth/data/dto/local_user_dto.dart';

/// Contract for auth local data access.
abstract interface class CPAuthLocalGateway {
  /// Returns user by [email], or null if not found.
  Future<CPLocalUserDto?> getUserByEmail(String email);

  /// Persists a newly registered [user].
  Future<void> saveUser(CPLocalUserDto user);

  /// Persists active session by [email].
  Future<void> saveSession(String email);

  /// Returns active session email.
  Future<String?> getSessionEmail();

  /// Clears active session.
  Future<void> clearSession();

  /// Stores biometric one-tap login preference for [email].
  Future<void> saveBiometricEmail(String email);

  /// Returns biometric-enabled email.
  Future<String?> getBiometricEmail();
}
