import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/profile/ui/views/profile_view.dart';
import 'package:casino_platform_test/src/features/widgetbook/ui/screens/widgetbook_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Profile tab screen shell.
class CPProfileScreen extends StatelessWidget {
  /// Route chunk for profile tab.
  static const String pathChunk = 'profile';

  /// Creates [CPProfileScreen].
  const CPProfileScreen({super.key});

  void _onLogoutTap(BuildContext context) {
    context.read<CPAuthCubit>().logout();
  }

  void _onOpenWidgetbookTap(BuildContext context) {
    context.pushRoute(CPWidgetbookScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CPAuthCubit, CPAuthState>(
      builder: (BuildContext context, CPAuthState state) {
        return switch (state) {
          CPAuthenticatedState(:final session) => CPProfileView(
              session: session,
              onLogoutTap: () => _onLogoutTap(context),
              onOpenWidgetbookTap: () => _onOpenWidgetbookTap(context),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
