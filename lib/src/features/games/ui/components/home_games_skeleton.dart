import 'package:casino_platform_test/src/shared/ui/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Loading skeleton for home tab games section.
class CPHomeGamesSkeleton extends StatelessWidget {
  /// Creates [CPHomeGamesSkeleton].
  const CPHomeGamesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CPAppShimmer(
      child: Column(
        children: <Widget>[
          _CPBlock(height: 160, borderRadius: 16),
          SizedBox(height: 14.h),
          Row(
            children: <Widget>[
              Expanded(child: _CPBlock(height: 170, borderRadius: 14)),
              SizedBox(width: 10.w),
              Expanded(child: _CPBlock(height: 170, borderRadius: 14)),
            ],
          ),
        ],
      ),
    );
  }
}

class _CPBlock extends StatelessWidget {
  const _CPBlock({
    required this.height,
    required this.borderRadius,
  });

  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
    );
  }
}
