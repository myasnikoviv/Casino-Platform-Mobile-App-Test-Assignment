import 'package:casino_platform_test/src/shared/ui/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Loading skeleton for games grid tab.
class CPGamesGridSkeleton extends StatelessWidget {
  /// Creates [CPGamesGridSkeleton].
  const CPGamesGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CPAppShimmer(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: _CPGridCell()),
              SizedBox(width: 10.w),
              Expanded(child: _CPGridCell()),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: <Widget>[
              Expanded(child: _CPGridCell()),
              SizedBox(width: 10.w),
              Expanded(child: _CPGridCell()),
            ],
          ),
        ],
      ),
    );
  }
}

class _CPGridCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(14.r),
      ),
    );
  }
}
