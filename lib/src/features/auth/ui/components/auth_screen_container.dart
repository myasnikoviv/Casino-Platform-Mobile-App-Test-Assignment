import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Standard auth screen scaffold wrapper with safe area and spacing.
class CPAuthScreenContainer extends StatelessWidget {
  /// Creates [CPAuthScreenContainer].
  const CPAuthScreenContainer({
    required this.child,
    this.showBackButton = false,
    super.key,
  });

  /// Content rendered inside auth layout shell.
  final Widget child;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showBackButton
          ? AppBar(
              leading: const BackButton(),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: child,
        ),
      ),
    );
  }
}
