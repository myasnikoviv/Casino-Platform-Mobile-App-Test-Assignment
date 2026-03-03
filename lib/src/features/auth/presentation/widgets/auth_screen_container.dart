import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Standard auth screen scaffold wrapper with safe area and spacing.
class AuthScreenContainer extends StatelessWidget {
  /// Creates [AuthScreenContainer].
  const AuthScreenContainer({
    required this.child,
    super.key,
  });

  /// Content rendered inside auth layout shell.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: child,
        ),
      ),
    );
  }
}
