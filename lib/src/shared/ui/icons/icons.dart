export 'package:casino_platform_test/src/shared/enums/icon_type.dart';

import 'package:casino_platform_test/src/shared/enums/icon_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
