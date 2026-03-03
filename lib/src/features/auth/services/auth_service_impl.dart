import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/core/utils/hash_utils.dart';
import 'package:casino_platform_test/src/features/auth/data/dto/local_user_dto.dart';
import 'package:casino_platform_test/src/features/auth/data/repositories/auth_local_repository.dart';
import 'package:casino_platform_test/src/features/auth/domain/entities/user_session.dart';
import 'package:casino_platform_test/src/features/auth/domain/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';

/// Default local auth service implementation.
class AuthServiceImpl implements AuthService {
  /// Creates [AuthServiceImpl].
  const AuthServiceImpl(this._repository, this._localAuth);

  final AuthLocalRepository _repository;
  final LocalAuthentication _localAuth;

  @override
  Future<UserSession> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final String normalizedEmail = email.trim().toLowerCase();
    final LocalUserDto? existing =
        await _repository.getUserByEmail(normalizedEmail);
    if (existing != null) {
      throw const AuthException(code: 'emailExists');
    }

    final DateTime now = DateTime.now();
    final LocalUserDto dto = LocalUserDto(
      id: now.microsecondsSinceEpoch.toString(),
      fullName: fullName.trim(),
      email: normalizedEmail,
      passwordHash: HashUtils.sha256Of(password),
      createdAtIso: now.toIso8601String(),
    );

    await _repository.saveUser(dto);
    await _repository.saveSession(normalizedEmail);

    return _toSession(dto);
  }

  @override
  Future<UserSession> login({
    required String email,
    required String password,
  }) async {
    final String normalizedEmail = email.trim().toLowerCase();
    final LocalUserDto? user =
        await _repository.getUserByEmail(normalizedEmail);
    if (user == null) {
      throw const AuthException(code: 'invalidCredentials');
    }

    final String hash = HashUtils.sha256Of(password);
    if (user.passwordHash != hash) {
      throw const AuthException(code: 'invalidCredentials');
    }

    await _repository.saveSession(normalizedEmail);
    return _toSession(user);
  }

  @override
  Future<UserSession?> restoreSession() async {
    final String? sessionEmail = await _repository.getSessionEmail();
    if (sessionEmail == null || sessionEmail.isEmpty) {
      return null;
    }
    final LocalUserDto? user = await _repository.getUserByEmail(sessionEmail);
    if (user == null) {
      await _repository.clearSession();
      return null;
    }
    return _toSession(user);
  }

  @override
  Future<void> logout() {
    return _repository.clearSession();
  }

  @override
  Future<bool> canUseBiometrics() async {
    return await _localAuth.canCheckBiometrics &&
        await _localAuth.isDeviceSupported();
  }

  @override
  Future<void> enableBiometricForCurrentSession() async {
    final String? email = await _repository.getSessionEmail();
    if (email == null || email.isEmpty) {
      throw const AuthException(code: 'authRequired');
    }
    await _repository.saveBiometricEmail(email);
  }

  @override
  Future<UserSession?> loginWithBiometrics() async {
    final bool supported = await canUseBiometrics();
    if (!supported) {
      return null;
    }

    final String? biometricEmail = await _repository.getBiometricEmail();
    if (biometricEmail == null || biometricEmail.isEmpty) {
      return null;
    }

    final bool authenticated = await _localAuth.authenticate(
      localizedReason: 'Authenticate to login quickly',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
      ),
    );
    if (!authenticated) {
      return null;
    }

    final LocalUserDto? user = await _repository.getUserByEmail(biometricEmail);
    if (user == null) {
      return null;
    }

    await _repository.saveSession(user.email);
    return _toSession(user);
  }

  UserSession _toSession(LocalUserDto dto) {
    final DateTime memberSince =
        DateTime.tryParse(dto.createdAtIso) ?? DateTime.now();
    return UserSession(
      id: dto.id,
      fullName: dto.fullName,
      email: dto.email,
      memberSince: DateFormat('MMM d, yyyy').format(memberSince),
    );
  }
}
