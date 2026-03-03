import 'package:flutter/material.dart';

/// Toggle action for obscured password fields.
class PasswordToggleButton extends StatelessWidget {
  /// Creates [PasswordToggleButton].
  const PasswordToggleButton({
    required this.isVisible,
    required this.showLabel,
    required this.hideLabel,
    required this.onTap,
    super.key,
  });

  /// Whether password is currently visible.
  final bool isVisible;

  /// Text shown for reveal state.
  final String showLabel;

  /// Text shown for hide state.
  final String hideLabel;

  /// Tap callback.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(isVisible ? hideLabel : showLabel),
    );
  }
}
