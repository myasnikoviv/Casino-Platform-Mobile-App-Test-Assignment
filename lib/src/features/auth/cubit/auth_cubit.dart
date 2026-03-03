import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/core/errors/guarded_executor.dart';
import 'package:casino_platform_test/src/features/auth/entities/user_session.dart';
import 'package:casino_platform_test/src/features/auth/services/auth_service.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Global auth cubit handling login, registration and session lifecycle.
class CPAuthCubit extends Cubit<CPAuthState> {
  /// Creates [CPAuthCubit].
  CPAuthCubit(this._authService, this._executor) : super(CPAuthState.initial());

  final CPAuthService _authService;
  final CPGuardedExecutor _executor;

  /// Restores saved session and device auth capabilities.
  Future<void> initialize() async {
    emit(state.copyWith(isBusy: true, clearError: true));
    try {
      final bool bioAvailable = await _authService.canUseBiometrics();
      final CPUserSession? session =
          await _executor.run(_authService.restoreSession);
      if (session == null) {
        emit(
          state.copyWith(
            status: CPAuthStatus.unauthenticated,
            clearSession: true,
            isBusy: false,
            biometricsAvailable: bioAvailable,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: CPAuthStatus.authenticated,
            session: session,
            isBusy: false,
            biometricsAvailable: bioAvailable,
          ),
        );
      }
    } on CPAppException catch (error) {
      emit(
        state.copyWith(
          status: CPAuthStatus.unauthenticated,
          clearSession: true,
          isBusy: false,
          error: error,
        ),
      );
    }
  }

  /// Performs email/password login.
  Future<void> login(String email, String password) async {
    emit(state.copyWith(isBusy: true, clearError: true));
    try {
      final CPUserSession session = await _executor.run(
        () => _authService.login(email: email, password: password),
      );
      emit(
        state.copyWith(
          status: CPAuthStatus.authenticated,
          session: session,
          isBusy: false,
        ),
      );
    } on CPAppException catch (error) {
      emit(state.copyWith(isBusy: false, error: error));
    }
  }

  /// Performs sign-up and starts a session.
  Future<void> register(String name, String email, String password) async {
    emit(state.copyWith(isBusy: true, clearError: true));
    try {
      final CPUserSession session = await _executor.run(
        () => _authService.register(
            fullName: name, email: email, password: password),
      );
      emit(
        state.copyWith(
          status: CPAuthStatus.authenticated,
          session: session,
          isBusy: false,
        ),
      );
    } on CPAppException catch (error) {
      emit(state.copyWith(isBusy: false, error: error));
    }
  }

  /// Logs out current user.
  Future<void> logout() async {
    emit(state.copyWith(isBusy: true, clearError: true));
    await _executor.run(_authService.logout);
    emit(
      state.copyWith(
        status: CPAuthStatus.unauthenticated,
        clearSession: true,
        isBusy: false,
      ),
    );
  }

  /// Tries quick biometric login flow.
  Future<void> loginWithBiometrics() async {
    emit(state.copyWith(isBusy: true, clearError: true));
    try {
      final CPUserSession? session =
          await _executor.run(_authService.loginWithBiometrics);
      if (session == null) {
        emit(state.copyWith(isBusy: false));
        return;
      }
      emit(
        state.copyWith(
          status: CPAuthStatus.authenticated,
          session: session,
          isBusy: false,
        ),
      );
    } on CPAppException catch (error) {
      emit(state.copyWith(isBusy: false, error: error));
    }
  }

  /// Enables biometric one-tap login on current account.
  Future<void> enableBiometric() async {
    emit(state.copyWith(isBusy: true, clearError: true));
    try {
      await _executor.run(_authService.enableBiometricForCurrentSession);
      emit(state.copyWith(isBusy: false));
    } on CPAppException catch (error) {
      emit(state.copyWith(isBusy: false, error: error));
    }
  }

  /// Clears current error state after user acknowledged it.
  void clearError() {
    emit(state.copyWith(clearError: true));
  }
}
