import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable profile info tile row.
class ProfileInfoTile extends StatelessWidget {
  /// Creates [ProfileInfoTile].
  const ProfileInfoTile({
    required this.label,
    required this.value,
    super.key,
  });

  /// Left label text.
  final String label;

  /// Right value text.
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label, style: AppTextStyles.label)),
          Text(value, style: AppTextStyles.body),
        ],
      ),
    );
  }
}
