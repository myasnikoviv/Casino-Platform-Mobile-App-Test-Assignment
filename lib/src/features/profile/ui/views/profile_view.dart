import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/auth/entities/user_session.dart';
import 'package:casino_platform_test/src/features/profile/ui/components/profile_header_card.dart';
import 'package:casino_platform_test/src/features/profile/ui/components/profile_info_tile.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Profile view.
class CPProfileView extends StatelessWidget {
  /// Creates [CPProfileView].
  const CPProfileView({
    required this.session,
    required this.biometricsAvailable,
    required this.biometricsEnabled,
    required this.isBusy,
    required this.onEnableBiometricTap,
    required this.onDisableBiometricTap,
    required this.onLogoutTap,
    required this.onOpenWidgetbookTap,
    super.key,
  });

  final CPUserSession session;
  final bool biometricsAvailable;
  final bool biometricsEnabled;
  final bool isBusy;
  final VoidCallback? onEnableBiometricTap;
  final VoidCallback? onDisableBiometricTap;
  final VoidCallback onLogoutTap;
  final VoidCallback onOpenWidgetbookTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(12.w),
      children: <Widget>[
        Text(context.l10n.profileHeader, style: CPAppTextStyles.h2),
        SizedBox(height: 12.h),
        CPProfileHeaderCard(session: session),
        SizedBox(height: 12.h),
        CPProfileInfoTile(
          label: context.l10n.memberSince,
          value: session.memberSince,
        ),
        SizedBox(height: 8.h),
        CPProfileInfoTile(
          label: context.l10n.accountId,
          value: session.id,
        ),
        SizedBox(height: 8.h),
        CPProfileInfoTile(
          label: context.l10n.notifications,
          value: context.l10n.enabled,
        ),
        SizedBox(height: 8.h),
        CPProfileInfoTile(
          label: context.l10n.language,
          value: context.l10n.english,
        ),
        SizedBox(height: 8.h),
        CPProfileInfoTile(
          label: context.l10n.biometricsStatusLabel,
          value: !biometricsAvailable
              ? context.l10n.biometricsUnavailableStatus
              : biometricsEnabled
                  ? context.l10n.enabled
                  : context.l10n.disabled,
        ),
        SizedBox(height: 8.h),
        CPAppButton(
          label: biometricsEnabled
              ? context.l10n.disableBiometric
              : context.l10n.enableBiometric,
          onPressed: !biometricsAvailable
              ? null
              : (biometricsEnabled
                  ? onDisableBiometricTap
                  : onEnableBiometricTap),
          isLoading: isBusy,
        ),
        if (kDebugMode) SizedBox(height: 12.h),
        if (kDebugMode)
          CPAppButton(
            label: context.l10n.openWidgetbook,
            onPressed: onOpenWidgetbookTap,
          ),
        SizedBox(height: 12.h),
        CPAppButton(
          label: context.l10n.logout,
          onPressed: onLogoutTap,
        ),
      ],
    );
  }
}
