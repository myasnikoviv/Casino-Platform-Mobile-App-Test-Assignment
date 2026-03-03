import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/core/exceptions/exception_codes.dart';
import 'package:casino_platform_test/src/core/exceptions/guarded_executor.dart';
import 'package:casino_platform_test/src/core/utils/hash_utils.dart';
import 'package:casino_platform_test/src/features/auth/data/dto/local_user_dto.dart';
import 'package:casino_platform_test/src/features/auth/data/gateways/auth_local_gateway.dart';
import 'package:casino_platform_test/src/features/auth/entities/user_session.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service.dart';
import 'package:local_auth/local_auth.dart';

/// Default local auth service implementation.
class CPAuthServiceImpl implements CPAuthService {
  /// Creates [CPAuthServiceImpl].
  const CPAuthServiceImpl(this._gateway, this._localAuth, this._executor);

  final CPAuthLocalGateway _gateway;
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
          await _gateway.getUserByEmail(normalizedEmail);
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

      await _gateway.saveUser(dto);
      await _gateway.saveSession(normalizedEmail);

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
          await _gateway.getUserByEmail(normalizedEmail);
      if (user == null) {
        throw const CPAuthException(code: CPAuthErrorCode.invalidCredentials);
      }

      final String hash = CPHashUtils.sha256Of(password);
      if (user.passwordHash != hash) {
        throw const CPAuthException(code: CPAuthErrorCode.invalidCredentials);
      }

      await _gateway.saveSession(normalizedEmail);
      return _toSession(user);
    });
  }

  @override
  Future<CPUserSession?> restoreSession() async {
    return _executor.run(() async {
      final String? sessionEmail = await _gateway.getSessionEmail();
      if (sessionEmail == null || sessionEmail.isEmpty) {
        return null;
      }
      final CPLocalUserDto? user = await _gateway.getUserByEmail(sessionEmail);
      if (user == null) {
        await _gateway.clearSession();
        return null;
      }
      return _toSession(user);
    });
  }

  @override
  Future<void> logout() {
    return _executor.run(_gateway.clearSession);
  }

  @override
  Future<bool> canUseBiometrics() async {
    return _executor.run(() async {
      final bool canCheck = await _localAuth.canCheckBiometrics;
      final bool isSupported = await _localAuth.isDeviceSupported();
      if (!canCheck || !isSupported) {
        return false;
      }
      final List<BiometricType> enrolled =
          await _localAuth.getAvailableBiometrics();
      return enrolled.isNotEmpty;
    });
  }

  @override
  Future<void> enableBiometricForCurrentSession() async {
    await _executor.run(() async {
      final bool supported = await canUseBiometrics();
      if (!supported) {
        throw const CPAuthException(
            code: CPAuthErrorCode.biometricsUnavailable);
      }

      final String? email = await _gateway.getSessionEmail();
      if (email == null || email.isEmpty) {
        throw const CPAuthException(code: CPAuthErrorCode.authRequired);
      }

      await _gateway.saveBiometricEmail(email);
    });
  }

  @override
  Future<void> disableBiometricForCurrentSession() async {
    await _executor.run(() async {
      final String? email = await _gateway.getSessionEmail();
      if (email == null || email.isEmpty) {
        throw const CPAuthException(code: CPAuthErrorCode.authRequired);
      }

      final String? biometricEmail = await _gateway.getBiometricEmail();
      if (biometricEmail == email) {
        await _gateway.clearBiometricEmail();
      }
    });
  }

  @override
  Future<bool> hasBiometricLoginConfigured() async {
    return _executor.run(() async {
      final String? email = await _gateway.getBiometricEmail();
      return email != null && email.isNotEmpty;
    });
  }

  @override
  Future<bool> isBiometricEnabledForCurrentSession() async {
    return _executor.run(() async {
      final String? sessionEmail = await _gateway.getSessionEmail();
      if (sessionEmail == null || sessionEmail.isEmpty) {
        return false;
      }
      final String? biometricEmail = await _gateway.getBiometricEmail();
      return biometricEmail == sessionEmail;
    });
  }

  @override
  Future<CPUserSession?> loginWithBiometrics() async {
    return _executor.run(() async {
      final bool supported = await canUseBiometrics();
      if (!supported) {
        throw const CPAuthException(
            code: CPAuthErrorCode.biometricsUnavailable);
      }

      final String? biometricEmail = await _gateway.getBiometricEmail();
      if (biometricEmail == null || biometricEmail.isEmpty) {
        throw const CPAuthException(code: CPAuthErrorCode.biometricsNotEnabled);
      }

      final bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to login quickly',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (!authenticated) {
        throw const CPAuthException(code: CPAuthErrorCode.biometricAuthFailed);
      }

      final CPLocalUserDto? user =
          await _gateway.getUserByEmail(biometricEmail);
      if (user == null) {
        throw const CPAuthException(code: CPAuthErrorCode.invalidCredentials);
      }

      await _gateway.saveSession(user.email);
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
      memberSince: _formatMemberSince(memberSince),
    );
  }

  String _formatMemberSince(DateTime date) {
    const List<String> months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
