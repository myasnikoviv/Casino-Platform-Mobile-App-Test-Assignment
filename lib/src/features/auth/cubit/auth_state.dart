import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/features/auth/entities/user_session.dart';
import 'package:equatable/equatable.dart';

/// Base sealed state for auth lifecycle.
sealed class CPAuthState extends Equatable {
  /// Creates [CPAuthState].
  const CPAuthState({
    required this.isBusy,
    required this.biometricsAvailable,
    this.error,
  });

  /// Async in-progress flag.
  final bool isBusy;

  /// Biometric capability flag.
  final bool biometricsAvailable;

  /// Last domain error.
  final CPAppException? error;

  @override
  List<Object?> get props => <Object?>[isBusy, biometricsAvailable, error];
}

/// Unknown state while bootstrap is in progress.
class CPAuthUnknownState extends CPAuthState {
  /// Creates [CPAuthUnknownState].
  const CPAuthUnknownState({
    super.isBusy = false,
    super.biometricsAvailable = false,
    super.error,
  });
}

/// State with no authenticated session.
class CPUnauthenticatedState extends CPAuthState {
  /// Creates [CPUnauthenticatedState].
  const CPUnauthenticatedState({
    super.isBusy = false,
    super.biometricsAvailable = false,
    super.error,
  });
}

/// State with active authenticated session.
class CPAuthenticatedState extends CPAuthState {
  /// Creates [CPAuthenticatedState].
  const CPAuthenticatedState({
    required this.session,
    super.isBusy = false,
    super.biometricsAvailable = false,
    super.error,
  });

  /// Active session data.
  final CPUserSession session;

  @override
  List<Object?> get props => <Object?>[
        session,
        isBusy,
        biometricsAvailable,
        error,
      ];
}
