import 'package:casino_platform_test/src/core/constants/app_constants.dart';
import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/core/storage/hive_secure_box_factory.dart';
import 'package:casino_platform_test/src/core/storage/secure_storage_service.dart';
import 'package:casino_platform_test/src/features/auth/data/dto/local_user_dto.dart';

/// Repository for local auth storage and session persistence.
class AuthLocalRepository {
  /// Creates local auth repository.
  const AuthLocalRepository(
    this._secureBoxFactory,
    this._secureStorageService,
  );

  final HiveSecureBoxFactory _secureBoxFactory;
  final SecureStorageService _secureStorageService;

  static const String _biometricEmailKey = 'biometric_email';

  /// Returns user by [email], or null if not found.
  Future<LocalUserDto?> getUserByEmail(String email) async {
    try {
      final box =
          await _secureBoxFactory.openEncryptedBox(AppConstants.usersBoxName);
      final dynamic raw = box.get(email.toLowerCase());
      if (raw is Map<dynamic, dynamic>) {
        return LocalUserDto.fromMap(raw);
      }
      return null;
    } catch (_) {
      throw const StorageException();
    }
  }

  /// Persists a newly registered [user].
  Future<void> saveUser(LocalUserDto user) async {
    try {
      final box =
          await _secureBoxFactory.openEncryptedBox(AppConstants.usersBoxName);
      await box.put(user.email.toLowerCase(), user.toMap());
    } catch (_) {
      throw const StorageException();
    }
  }

  /// Persists active session by [email].
  Future<void> saveSession(String email) {
    return _secureStorageService.write(AppConstants.sessionEmailKey, email);
  }

  /// Returns active session email.
  Future<String?> getSessionEmail() {
    return _secureStorageService.read(AppConstants.sessionEmailKey);
  }

  /// Clears active session.
  Future<void> clearSession() {
    return _secureStorageService.delete(AppConstants.sessionEmailKey);
  }

  /// Stores biometric one-tap login preference for [email].
  Future<void> saveBiometricEmail(String email) {
    return _secureStorageService.write(_biometricEmailKey, email);
  }

  /// Returns biometric-enabled email.
  Future<String?> getBiometricEmail() {
    return _secureStorageService.read(_biometricEmailKey);
  }
}
