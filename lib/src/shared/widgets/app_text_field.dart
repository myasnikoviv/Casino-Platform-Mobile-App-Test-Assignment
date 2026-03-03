import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable text field with consistent spacing and behavior.
class AppTextField extends StatelessWidget {
  /// Creates [AppTextField].
  const AppTextField({
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.keyboardType,
    this.autofillHints,
    this.suffix,
    this.onChanged,
    super.key,
  });

  /// Controller for text content.
  final TextEditingController controller;

  /// Field label displayed to user.
  final String label;

  /// Obscures input for password-like values.
  final bool obscureText;

  /// Keyboard type selection.
  final TextInputType? keyboardType;

  /// Autofill hints forwarded to native platform.
  final Iterable<String>? autofillHints;

  /// Optional trailing widget.
  final Widget? suffix;

  /// Optional text change callback.
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
