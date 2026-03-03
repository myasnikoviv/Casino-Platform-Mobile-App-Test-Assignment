import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/features/auth/domain/entities/user_session.dart';
import 'package:equatable/equatable.dart';

/// Authentication status in application lifecycle.
enum AuthStatus {
  /// Startup state while session restoration is running.
  unknown,

  /// No active session.
  unauthenticated,

  /// Active logged-in session available.
  authenticated,
}

/// UI state for the auth cubit.
class AuthState extends Equatable {
  /// Creates [AuthState].
  const AuthState({
    required this.status,
    this.session,
    this.isBusy = false,
    this.error,
    this.biometricsAvailable = false,
  });

  /// Current auth status.
  final AuthStatus status;

  /// Active user session, if available.
  final UserSession? session;

  /// Busy flag for async actions.
  final bool isBusy;

  /// Last raised app exception.
  final AppException? error;

  /// Whether biometrics are supported by the device.
  final bool biometricsAvailable;

  /// Initial state factory.
  factory AuthState.initial() => const AuthState(status: AuthStatus.unknown);

  /// Returns updated immutable state.
  AuthState copyWith({
    AuthStatus? status,
    UserSession? session,
    bool clearSession = false,
    bool? isBusy,
    AppException? error,
    bool clearError = false,
    bool? biometricsAvailable,
  }) {
    return AuthState(
      status: status ?? this.status,
      session: clearSession ? null : session ?? this.session,
      isBusy: isBusy ?? this.isBusy,
      error: clearError ? null : error ?? this.error,
      biometricsAvailable: biometricsAvailable ?? this.biometricsAvailable,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        status,
        session,
        isBusy,
        error,
        biometricsAvailable,
      ];
}
