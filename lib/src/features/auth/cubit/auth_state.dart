import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/features/auth/entities/user_session.dart';
import 'package:equatable/equatable.dart';

/// Authentication status in application lifecycle.
enum CPAuthStatus {
  /// Startup state while session restoration is running.
  unknown,

  /// No active session.
  unauthenticated,

  /// Active logged-in session available.
  authenticated,
}

/// UI state for the auth cubit.
class CPAuthState extends Equatable {
  /// Creates [CPAuthState].
  const CPAuthState({
    required this.status,
    this.session,
    this.isBusy = false,
    this.error,
    this.biometricsAvailable = false,
  });

  /// Current auth status.
  final CPAuthStatus status;

  /// Active user session, if available.
  final CPUserSession? session;

  /// Busy flag for async actions.
  final bool isBusy;

  /// Last raised app exception.
  final CPAppException? error;

  /// Whether biometrics are supported by the device.
  final bool biometricsAvailable;

  /// Initial state factory.
  factory CPAuthState.initial() =>
      const CPAuthState(status: CPAuthStatus.unknown);

  /// Returns updated immutable state.
  CPAuthState copyWith({
    CPAuthStatus? status,
    CPUserSession? session,
    bool clearSession = false,
    bool? isBusy,
    CPAppException? error,
    bool clearError = false,
    bool? biometricsAvailable,
  }) {
    return CPAuthState(
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
