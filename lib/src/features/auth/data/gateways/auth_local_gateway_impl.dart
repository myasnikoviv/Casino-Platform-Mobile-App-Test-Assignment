import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/core/storage/hive_secure_box_factory.dart';
import 'package:casino_platform_test/src/core/storage/secure_storage_service.dart';
import 'package:casino_platform_test/src/features/auth/data/dto/local_user_dto.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/auth_local_gateway.dart';
import 'package:casino_platform_test/src/core/constants/app_constants.dart';

/// Gateway for local auth storage and session persistence.
class CPAuthLocalGatewayImpl implements CPAuthLocalGateway {
  /// Creates local auth gateway.
  const CPAuthLocalGatewayImpl(
    this._secureBoxFactory,
    this._secureStorageService,
  );

  final CPSecureBoxFactory _secureBoxFactory;
  final CPSecureStorageService _secureStorageService;

  /// Returns user by [email], or null if not found.
  @override
  Future<CPLocalUserDto?> getUserByEmail(String email) async {
    try {
      final box =
          await _secureBoxFactory.openEncryptedBox(CPAppConstants.usersBoxName);
      final dynamic raw = box.get(email.toLowerCase());
      if (raw is Map<dynamic, dynamic>) {
        return CPLocalUserDto.fromMap(raw);
      }
      return null;
    } catch (_) {
      throw const CPStorageException();
    }
  }

  /// Persists a newly registered [user].
  @override
  Future<void> saveUser(CPLocalUserDto user) async {
    try {
      final box =
          await _secureBoxFactory.openEncryptedBox(CPAppConstants.usersBoxName);
      await box.put(user.email.toLowerCase(), user.toMap());
    } catch (_) {
      throw const CPStorageException();
    }
  }

  /// Persists active session by [email].
  @override
  Future<void> saveSession(String email) {
    return _secureStorageService.write(CPAppConstants.sessionEmailKey, email);
  }

  /// Returns active session email.
  @override
  Future<String?> getSessionEmail() {
    return _secureStorageService.read(CPAppConstants.sessionEmailKey);
  }

  /// Clears active session.
  @override
  Future<void> clearSession() {
    return _secureStorageService.delete(CPAppConstants.sessionEmailKey);
  }
}
