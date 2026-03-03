import 'package:cached_network_image/cached_network_image.dart';
import 'package:casino_platform_test/src/shared/ui/app_shimmer.dart';
import 'package:casino_platform_test/src/shared/ui/icons/icons.dart';
import 'package:flutter/material.dart';

/// Shared cached network image with shimmer placeholder and error fallback.
class CPAppCachedNetworkImage extends StatelessWidget {
  /// Creates [CPAppCachedNetworkImage].
  const CPAppCachedNetworkImage({
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    super.key,
  });

  /// Remote image URL.
  final String imageUrl;

  /// How the image should be inscribed into layout bounds.
  final BoxFit fit;

  /// Optional width override.
  final double? width;

  /// Optional height override.
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (_, __) => const _CPImageSkeleton(),
      errorWidget: (_, __, ___) => const _CPImageError(),
    );
  }
}

class _CPImageSkeleton extends StatelessWidget {
  const _CPImageSkeleton();

  @override
  Widget build(BuildContext context) {
    return const CPAppShimmer(
      child: ColoredBox(
        color: Color(0xFFE2E8F0),
        child: SizedBox.expand(),
      ),
    );
  }
}

class _CPImageError extends StatelessWidget {
  const _CPImageError();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFE2E8F0),
      child: Center(
        child: CPIcon(
          type: CPIconType.warning,
          size: 20,
          color: Color(0xFF64748B),
        ),
      ),
    );
  }
}
