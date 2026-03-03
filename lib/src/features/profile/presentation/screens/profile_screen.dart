import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:casino_platform_test/src/features/profile/presentation/widgets/profile_info_tile.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/widgets/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Profile tab containing account data and logout action.
class ProfileScreen extends StatelessWidget {
  /// Route segment for profile tab.
  static const String routeSegment = 'profile';

  /// Creates [ProfileScreen].
  const ProfileScreen({super.key});

  void _onLogoutTap(BuildContext context) {
    context.read<AuthCubit>().logout();
  }

  void _onOpenWidgetbookTap(BuildContext context) {
    context.push(RoutePaths.widgetbook);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, AuthState state) {
        final session = state.session;
        if (session == null) {
          return const SizedBox.shrink();
        }

        return ListView(
          padding: EdgeInsets.all(12.w),
          children: <Widget>[
            Text(context.l10n.text('profileHeader'), style: AppTextStyles.h2),
            SizedBox(height: 12.h),
            ProfileHeaderCard(session: session),
            SizedBox(height: 12.h),
            ProfileInfoTile(
              label: context.l10n.text('memberSince'),
              value: session.memberSince,
            ),
            SizedBox(height: 8.h),
            ProfileInfoTile(
              label: context.l10n.text('accountId'),
              value: session.id,
            ),
            SizedBox(height: 8.h),
            ProfileInfoTile(
              label: context.l10n.text('notifications'),
              value: context.l10n.text('enabled'),
            ),
            SizedBox(height: 8.h),
            ProfileInfoTile(
              label: context.l10n.text('language'),
              value: context.l10n.text('english'),
            ),
            if (kDebugMode) SizedBox(height: 12.h),
            if (kDebugMode)
              AppButton(
                label: context.l10n.text('openWidgetbook'),
                onPressed: () => _onOpenWidgetbookTap(context),
              ),
            SizedBox(height: 12.h),
            AppButton(
              label: context.l10n.text('logout'),
              onPressed: () => _onLogoutTap(context),
            ),
          ],
        );
      },
    );
  }
}
