import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/profile/components/profile_header_card.dart';
import 'package:casino_platform_test/src/features/profile/components/profile_info_tile.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/widgets/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Profile tab containing account data and logout action.
class CPProfileScreen extends StatelessWidget {
  /// Route segment for profile tab.
  static const String routeSegment = 'profile';

  /// Creates [CPProfileScreen].
  const CPProfileScreen({super.key});

  void _onLogoutTap(BuildContext context) {
    context.read<CPAuthCubit>().logout();
  }

  void _onOpenWidgetbookTap(BuildContext context) {
    context.pushRoute(CPRoutePaths.widgetbook);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CPAuthCubit, CPAuthState>(
      builder: (BuildContext context, CPAuthState state) {
        final session = state.session;
        if (session == null) {
          return const SizedBox.shrink();
        }

        return ListView(
          padding: EdgeInsets.all(12.w),
          children: <Widget>[
            Text(context.l10n.text('profileHeader'), style: CPAppTextStyles.h2),
            SizedBox(height: 12.h),
            CPProfileHeaderCard(session: session),
            SizedBox(height: 12.h),
            CPProfileInfoTile(
              label: context.l10n.text('memberSince'),
              value: session.memberSince,
            ),
            SizedBox(height: 8.h),
            CPProfileInfoTile(
              label: context.l10n.text('accountId'),
              value: session.id,
            ),
            SizedBox(height: 8.h),
            CPProfileInfoTile(
              label: context.l10n.text('notifications'),
              value: context.l10n.text('enabled'),
            ),
            SizedBox(height: 8.h),
            CPProfileInfoTile(
              label: context.l10n.text('language'),
              value: context.l10n.text('english'),
            ),
            if (kDebugMode) SizedBox(height: 12.h),
            if (kDebugMode)
              CPAppButton(
                label: context.l10n.text('openWidgetbook'),
                onPressed: () => _onOpenWidgetbookTap(context),
              ),
            SizedBox(height: 12.h),
            CPAppButton(
              label: context.l10n.text('logout'),
              onPressed: () => _onLogoutTap(context),
            ),
          ],
        );
      },
    );
  }
}
