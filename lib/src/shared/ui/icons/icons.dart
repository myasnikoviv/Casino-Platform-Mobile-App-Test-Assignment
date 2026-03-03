import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Icon token set used across the app.
enum CPIconType {
  home,
  homeOutlined,
  games,
  gamesOutlined,
  profile,
  profileOutlined,
  fingerprint,
  copy,
  warning,
}

extension CPIconTypeX on CPIconType {
  IconData get data {
    return switch (this) {
      CPIconType.home => Icons.home,
      CPIconType.homeOutlined => Icons.home_outlined,
      CPIconType.games => Icons.casino,
      CPIconType.gamesOutlined => Icons.casino_outlined,
      CPIconType.profile => Icons.person,
      CPIconType.profileOutlined => Icons.person_outline,
      CPIconType.fingerprint => Icons.fingerprint,
      CPIconType.copy => Icons.copy,
      CPIconType.warning => Icons.warning_amber_rounded,
    };
  }
}

/// App icon widget that resolves icon data from [CPIconType].
class CPIcon extends StatelessWidget {
  /// Creates [CPIcon].
  const CPIcon({
    required this.type,
    this.color,
    this.size,
    super.key,
  });

  /// Tokenized icon type.
  final CPIconType type;

  /// Optional icon color.
  final Color? color;

  /// Optional icon size in design points.
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      type.data,
      color: color,
      size: size?.sp,
    );
  }
}
