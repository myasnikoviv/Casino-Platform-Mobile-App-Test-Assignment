import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/core/exceptions/exception_codes.dart';
import 'package:casino_platform_test/src/core/exceptions/guarded_executor.dart';
import 'package:casino_platform_test/src/core/utils/hash_utils.dart';
import 'package:casino_platform_test/src/features/auth/data/dto/local_user_dto.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/auth_local_gateway.dart';
import 'package:casino_platform_test/src/features/auth/entities/user_session.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';

/// Default local auth service implementation.
class CPAuthServiceImpl implements CPAuthService {
  /// Creates [CPAuthServiceImpl].
  const CPAuthServiceImpl(this._repository, this._localAuth, this._executor);

  final CPAuthLocalGateway _repository;
  final LocalAuthentication _localAuth;
  final CPGuardedExecutor _executor;

  @override
  Future<CPUserSession> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return _executor.run(() async {
      final String normalizedEmail = email.trim().toLowerCase();
      final CPLocalUserDto? existing =
          await _repository.getUserByEmail(normalizedEmail);
      if (existing != null) {
        throw const CPAuthException(code: CPAuthErrorCode.emailExists);
      }

      final DateTime now = DateTime.now();
      final CPLocalUserDto dto = CPLocalUserDto(
        id: now.microsecondsSinceEpoch.toString(),
        fullName: fullName.trim(),
        email: normalizedEmail,
        passwordHash: CPHashUtils.sha256Of(password),
        createdAtIso: now.toIso8601String(),
      );

      await _repository.saveUser(dto);
      await _repository.saveSession(normalizedEmail);

      return _toSession(dto);
    });
  }

  @override
  Future<CPUserSession> login({
    required String email,
    required String password,
  }) async {
    return _executor.run(() async {
      final String normalizedEmail = email.trim().toLowerCase();
      final CPLocalUserDto? user =
          await _repository.getUserByEmail(normalizedEmail);
      if (user == null) {
        throw const CPAuthException(code: CPAuthErrorCode.invalidCredentials);
      }

      final String hash = CPHashUtils.sha256Of(password);
      if (user.passwordHash != hash) {
        throw const CPAuthException(code: CPAuthErrorCode.invalidCredentials);
      }

      await _repository.saveSession(normalizedEmail);
      return _toSession(user);
    });
  }

  @override
  Future<CPUserSession?> restoreSession() async {
    return _executor.run(() async {
      final String? sessionEmail = await _repository.getSessionEmail();
      if (sessionEmail == null || sessionEmail.isEmpty) {
        return null;
      }
      final CPLocalUserDto? user =
          await _repository.getUserByEmail(sessionEmail);
      if (user == null) {
        await _repository.clearSession();
        return null;
      }
      return _toSession(user);
    });
  }

  @override
  Future<void> logout() {
    return _executor.run(_repository.clearSession);
  }

  @override
  Future<bool> canUseBiometrics() async {
    return _executor.run(() async {
      return await _localAuth.canCheckBiometrics &&
          await _localAuth.isDeviceSupported();
    });
  }

  @override
  Future<void> enableBiometricForCurrentSession() async {
    await _executor.run(() async {
      final String? email = await _repository.getSessionEmail();
      if (email == null || email.isEmpty) {
        throw const CPAuthException(code: CPAuthErrorCode.authRequired);
      }
      await _repository.saveBiometricEmail(email);
    });
  }

  @override
  Future<CPUserSession?> loginWithBiometrics() async {
    return _executor.run(() async {
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

      final CPLocalUserDto? user =
          await _repository.getUserByEmail(biometricEmail);
      if (user == null) {
        return null;
      }

      await _repository.saveSession(user.email);
      return _toSession(user);
    });
  }

  CPUserSession _toSession(CPLocalUserDto dto) {
    final DateTime memberSince =
        DateTime.tryParse(dto.createdAtIso) ?? DateTime.now();
    return CPUserSession(
      id: dto.id,
      fullName: dto.fullName,
      email: dto.email,
      memberSince: DateFormat('MMM d, yyyy').format(memberSince),
    );
  }
}
