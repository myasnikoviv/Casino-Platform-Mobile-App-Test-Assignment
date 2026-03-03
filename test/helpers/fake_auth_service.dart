import 'package:casino_platform_test/src/features/auth/entities/user_session.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service.dart';

/// Test double for auth service with configurable responses.
class CPFakeAuthService implements CPAuthService {
  CPFakeAuthService({
    this.registerResult,
    this.loginResult,
    this.restoreResult,
    this.biometricLoginResult,
    this.canUseBiometricsResult = false,
    this.registerError,
    this.loginError,
    this.restoreError,
    this.biometricLoginError,
    this.enableBiometricError,
  });

  CPUserSession? registerResult;
  CPUserSession? loginResult;
  CPUserSession? restoreResult;
  CPUserSession? biometricLoginResult;
  bool canUseBiometricsResult;

  Exception? registerError;
  Exception? loginError;
  Exception? restoreError;
  Exception? biometricLoginError;
  Exception? enableBiometricError;

  int loginCalls = 0;
  int registerCalls = 0;
  int logoutCalls = 0;

  @override
  Future<bool> canUseBiometrics() async => canUseBiometricsResult;

  @override
  Future<void> enableBiometricForCurrentSession() async {
    if (enableBiometricError != null) {
      throw enableBiometricError!;
    }
  }

  @override
  Future<CPUserSession> login({
    required String email,
    required String password,
  }) async {
    loginCalls++;
    if (loginError != null) {
      throw loginError!;
    }
    if (loginResult == null) {
      throw StateError('loginResult must be set for test');
    }
    return loginResult!;
  }

  @override
  Future<CPUserSession?> loginWithBiometrics() async {
    if (biometricLoginError != null) {
      throw biometricLoginError!;
    }
    return biometricLoginResult;
  }

  @override
  Future<void> logout() async {
    logoutCalls++;
  }

  @override
  Future<CPUserSession> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    registerCalls++;
    if (registerError != null) {
      throw registerError!;
    }
    if (registerResult == null) {
      throw StateError('registerResult must be set for test');
    }
    return registerResult!;
  }

  @override
  Future<CPUserSession?> restoreSession() async {
    if (restoreError != null) {
      throw restoreError!;
    }
    return restoreResult;
  }
}
