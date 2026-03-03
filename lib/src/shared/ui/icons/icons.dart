import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Icon token set used across the app.
enum CPIconType {
  home(Icons.home),
  homeOutlined(Icons.home_outlined),
  games(Icons.casino),
  gamesOutlined(Icons.casino_outlined),
  profile(Icons.person),
  profileOutlined(Icons.person_outline),
  fingerprint(Icons.fingerprint),
  copy(Icons.copy),
  warning(Icons.warning_amber_rounded);

  const CPIconType(this.data);

  final IconData data;
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
