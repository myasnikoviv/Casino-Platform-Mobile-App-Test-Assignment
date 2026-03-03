/// View model for biometric setup view.
class CPBiometricSetupViewModel {
  /// Creates [CPBiometricSetupViewModel].
  const CPBiometricSetupViewModel({
    required this.title,
    required this.description,
    required this.enableLabel,
    required this.skipLabel,
    required this.canEnable,
    required this.isLoading,
  });

  /// Header title text.
  final String title;

  /// Informational body text.
  final String description;

  /// Enable button label.
  final String enableLabel;

  /// Skip button label.
  final String skipLabel;

  /// Enable action availability flag.
  final bool canEnable;

  /// Async progress flag.
  final bool isLoading;
}
