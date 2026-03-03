/// Centralized route path constants to avoid string duplication.
abstract final class RoutePaths {
  /// Login screen route path.
  static const String login = '/auth/login';

  /// Sign-up screen route path.
  static const String signUp = '/auth/sign-up';

  /// Password reveal checkpoint route path.
  static const String passwordReview = '/auth/password-review';

  /// Biometric setup route path.
  static const String biometricSetup = '/auth/biometric-setup';

  /// Main shell route path.
  static const String shell = '/main';

  /// Game details route path.
  static const String gameDetails = '/main/game/:gameId';

  /// Widgetbook route path.
  static const String widgetbook = '/main/profile/widgetbook';
}
