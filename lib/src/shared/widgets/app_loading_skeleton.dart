import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Simple shimmer-like animated skeleton placeholder.
class AppLoadingSkeleton extends StatefulWidget {
  /// Creates [AppLoadingSkeleton].
  const AppLoadingSkeleton({required this.height, super.key});

  /// Placeholder height.
  final double height;

  @override
  State<AppLoadingSkeleton> createState() => _AppLoadingSkeletonState();
}

class _AppLoadingSkeletonState extends State<AppLoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Color.lerp(
              const Color(0xFFE2E8F0),
              const Color(0xFFCBD5E1),
              _controller.value,
            ),
          ),
        );
      },
    );
  }
}
