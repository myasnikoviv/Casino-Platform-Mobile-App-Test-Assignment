import 'package:casino_platform_test/src/shared/ui/app_text_button.dart';
import 'package:flutter/material.dart';

/// Toggle action for obscured password fields.
class CPPasswordToggleButton extends StatelessWidget {
  /// Creates [CPPasswordToggleButton].
  const CPPasswordToggleButton({
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
    return CPAppTextButton(
      label: isVisible ? hideLabel : showLabel,
      onPressed: onTap,
    );
  }
}
