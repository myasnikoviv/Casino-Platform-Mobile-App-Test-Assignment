import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// App-styled text action button.
class CPAppTextButton extends StatelessWidget {
  /// Creates [CPAppTextButton].
  const CPAppTextButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  /// Button label.
  final String label;

  /// Tap callback.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: CPAppColors.primary,
      ),
      child: Text(label, style: CPAppTextStyles.body),
    );
  }
}
