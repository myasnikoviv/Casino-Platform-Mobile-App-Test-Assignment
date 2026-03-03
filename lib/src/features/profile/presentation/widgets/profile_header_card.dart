import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/auth/domain/entities/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Header card showing current user identity and avatar initials.
class ProfileHeaderCard extends StatelessWidget {
  /// Creates [ProfileHeaderCard].
  const ProfileHeaderCard({required this.session, super.key});

  /// Current signed-in session.
  final UserSession session;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 24.r,
              child: Text(session.initials),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(session.fullName, style: AppTextStyles.h2),
                  Text(session.email, style: AppTextStyles.body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
