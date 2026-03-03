import 'package:flutter/material.dart';

/// Reusable shimmer animation wrapper.
class CPAppShimmer extends StatefulWidget {
  /// Creates [CPAppShimmer].
  const CPAppShimmer({
    required this.child,
    this.baseColor = const Color(0xFFE2E8F0),
    this.highlightColor = const Color(0xFFF1F5F9),
    super.key,
  });

  /// Shimmered child.
  final Widget child;

  /// Base skeleton color.
  final Color baseColor;

  /// Highlight skeleton color.
  final Color highlightColor;

  @override
  State<CPAppShimmer> createState() => _CPAppShimmerState();
}

class _CPAppShimmerState extends State<CPAppShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
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
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (Rect bounds) {
            final double t = _controller.value;
            return LinearGradient(
              begin: Alignment(-1.0 + (2.0 * t), 0),
              end: Alignment(1.0 + (2.0 * t), 0),
              colors: <Color>[
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const <double>[0.2, 0.5, 0.8],
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }
}
