import 'package:casino_platform_test/src/shared/ui/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable rectangular skeleton placeholder based on shimmer.
class CPAppLoadingSkeleton extends StatelessWidget {
  /// Creates [CPAppLoadingSkeleton].
  const CPAppLoadingSkeleton({required this.height, super.key});

  /// Placeholder height.
  final double height;

  @override
  Widget build(BuildContext context) {
    return CPAppShimmer(
      child: Container(
        width: double.infinity,
        height: height.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: const Color(0xFFE2E8F0),
        ),
      ),
    );
  }
}
