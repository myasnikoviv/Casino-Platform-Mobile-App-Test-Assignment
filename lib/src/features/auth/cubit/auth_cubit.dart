import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/features/auth/entities/user_session.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Global auth cubit handling login, registration and session lifecycle.
class CPAuthCubit extends Cubit<CPAuthState> {
  /// Creates [CPAuthCubit].
  CPAuthCubit(this._authService) : super(const CPAuthUnknownState());

  final CPAuthService _authService;
  bool _initialized = false;

  /// Restores saved session and device auth capabilities.
  Future<void> initialize() async {
    if (_initialized) {
      return;
    }
    _initialized = true;
    emit(const CPAuthUnknownState(isBusy: true));
    try {
      final bool bioAvailable = await _authService.canUseBiometrics();
      final bool biometricConfigured =
          await _authService.hasBiometricLoginConfigured();
      final CPUserSession? session = await _authService.restoreSession();
      if (session == null) {
        emit(
          CPUnauthenticatedState(
            biometricsAvailable: bioAvailable,
            biometricsEnabled: biometricConfigured,
          ),
        );
      } else {
        final bool biometricEnabledForSession =
            await _authService.isBiometricEnabledForCurrentSession();
        emit(
          CPAuthenticatedState(
            session: session,
            biometricsAvailable: bioAvailable,
            biometricsEnabled: biometricEnabledForSession,
          ),
        );
      }
    } on CPAppException catch (error) {
      emit(CPUnauthenticatedState(error: error));
    }
  }

  /// Performs email/password login.
  Future<void> login(String email, String password) async {
    final bool bio = state.biometricsAvailable;
    final bool bioEnabled = state.biometricsEnabled;
    emit(CPUnauthenticatedState(
      isBusy: true,
      biometricsAvailable: bio,
      biometricsEnabled: bioEnabled,
    ));
    try {
      final CPUserSession session =
          await _authService.login(email: email, password: password);
      final bool enabledForSession =
          await _authService.isBiometricEnabledForCurrentSession();
      emit(CPAuthenticatedState(
        session: session,
        biometricsAvailable: bio,
        biometricsEnabled: enabledForSession,
      ));
    } on CPAppException catch (error) {
      emit(CPUnauthenticatedState(
        error: error,
        biometricsAvailable: bio,
        biometricsEnabled: bioEnabled,
      ));
    }
  }

  /// Performs sign-up and starts a session.
  Future<void> register(String name, String email, String password) async {
    final bool bio = state.biometricsAvailable;
    final bool bioEnabled = state.biometricsEnabled;
    emit(CPUnauthenticatedState(
      isBusy: true,
      biometricsAvailable: bio,
      biometricsEnabled: bioEnabled,
    ));
    try {
      final CPUserSession session = await _authService.register(
        fullName: name,
        email: email,
        password: password,
      );
      emit(CPAuthenticatedState(
        session: session,
        biometricsAvailable: bio,
        biometricsEnabled: false,
      ));
    } on CPAppException catch (error) {
      emit(CPUnauthenticatedState(
        error: error,
        biometricsAvailable: bio,
        biometricsEnabled: bioEnabled,
      ));
    }
  }

  /// Logs out current user.
  Future<void> logout() async {
    final bool bio = state.biometricsAvailable;
    final bool bioEnabled = state.biometricsEnabled;
    emit(CPUnauthenticatedState(
      isBusy: true,
      biometricsAvailable: bio,
      biometricsEnabled: bioEnabled,
    ));
    await _authService.logout();
    final bool biometricConfigured =
        await _authService.hasBiometricLoginConfigured();
    emit(CPUnauthenticatedState(
      biometricsAvailable: bio,
      biometricsEnabled: biometricConfigured,
    ));
  }

  /// Tries quick biometric login flow.
  Future<void> loginWithBiometrics() async {
    final bool bio = state.biometricsAvailable;
    final bool bioEnabled = state.biometricsEnabled;
    emit(CPUnauthenticatedState(
      isBusy: true,
      biometricsAvailable: bio,
      biometricsEnabled: bioEnabled,
    ));
    try {
      final CPUserSession? session = await _authService.loginWithBiometrics();
      if (session == null) {
        emit(CPUnauthenticatedState(
          biometricsAvailable: bio,
          biometricsEnabled: bioEnabled,
        ));
        return;
      }
      emit(CPAuthenticatedState(
        session: session,
        biometricsAvailable: bio,
        biometricsEnabled: true,
      ));
    } on CPAppException catch (error) {
      emit(CPUnauthenticatedState(
        error: error,
        biometricsAvailable: bio,
        biometricsEnabled: bioEnabled,
      ));
    }
  }

  /// Enables biometric one-tap login on current account.
  Future<bool> enableBiometric() async {
    final bool bio = state.biometricsAvailable;
    final bool bioEnabled = state.biometricsEnabled;
    final CPUserSession? session = state is CPAuthenticatedState
        ? (state as CPAuthenticatedState).session
        : null;
    if (session == null) {
      emit(CPUnauthenticatedState(
        biometricsAvailable: bio,
        biometricsEnabled: bioEnabled,
      ));
      return false;
    }

    emit(CPAuthenticatedState(
      session: session,
      isBusy: true,
      biometricsAvailable: bio,
      biometricsEnabled: bioEnabled,
    ));
    try {
      await _authService.enableBiometricForCurrentSession();
      emit(CPAuthenticatedState(
        session: session,
        biometricsAvailable: bio,
        biometricsEnabled: true,
      ));
      return true;
    } on CPAppException catch (error) {
      emit(CPAuthenticatedState(
        session: session,
        error: error,
        biometricsAvailable: bio,
        biometricsEnabled: bioEnabled,
      ));
      return false;
    }
  }

  /// Disables biometric one-tap login on current account.
  Future<bool> disableBiometric() async {
    final bool bio = state.biometricsAvailable;
    final bool bioEnabled = state.biometricsEnabled;
    final CPUserSession? session = state is CPAuthenticatedState
        ? (state as CPAuthenticatedState).session
        : null;
    if (session == null) {
      emit(CPUnauthenticatedState(
        biometricsAvailable: bio,
        biometricsEnabled: bioEnabled,
      ));
      return false;
    }

    emit(CPAuthenticatedState(
      session: session,
      isBusy: true,
      biometricsAvailable: bio,
      biometricsEnabled: bioEnabled,
    ));
    try {
      await _authService.disableBiometricForCurrentSession();
      emit(CPAuthenticatedState(
        session: session,
        biometricsAvailable: bio,
        biometricsEnabled: false,
      ));
      return true;
    } on CPAppException catch (error) {
      emit(CPAuthenticatedState(
        session: session,
        error: error,
        biometricsAvailable: bio,
        biometricsEnabled: bioEnabled,
      ));
      return false;
    }
  }

  /// Clears current error state after user acknowledged it.
  void clearError() {
    final bool bio = state.biometricsAvailable;
    final bool bioEnabled = state.biometricsEnabled;
    switch (state) {
      case CPAuthUnknownState():
        emit(CPAuthUnknownState(
          biometricsAvailable: bio,
          biometricsEnabled: bioEnabled,
        ));
      case CPUnauthenticatedState(:final isBusy):
        emit(CPUnauthenticatedState(
          isBusy: isBusy,
          biometricsAvailable: bio,
          biometricsEnabled: bioEnabled,
        ));
      case CPAuthenticatedState(:final session, :final isBusy):
        emit(CPAuthenticatedState(
          session: session,
          isBusy: isBusy,
          biometricsAvailable: bio,
          biometricsEnabled: bioEnabled,
        ));
    }
  }
}
