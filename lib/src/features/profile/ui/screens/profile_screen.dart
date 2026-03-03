import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/core/exceptions/error_mapper.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/profile/ui/views/profile_view.dart';
import 'package:casino_platform_test/src/features/widgetbook/ui/screens/widgetbook_screen.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
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

  Future<void> _onEnableBiometricTap(BuildContext context) async {
    final bool success = await context.read<CPAuthCubit>().enableBiometric();
    if (!context.mounted || success) {
      return;
    }
    final CPAuthState state = context.read<CPAuthCubit>().state;
    final exception = state.error;
    if (exception == null) {
      return;
    }
    final String message =
        CPErrorMapper().mapToMessage(exception, context.l10n);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    context.read<CPAuthCubit>().clearError();
  }

  Future<void> _onDisableBiometricTap(BuildContext context) async {
    final bool success = await context.read<CPAuthCubit>().disableBiometric();
    if (!context.mounted || success) {
      return;
    }
    final CPAuthState state = context.read<CPAuthCubit>().state;
    final exception = state.error;
    if (exception == null) {
      return;
    }
    final String message =
        CPErrorMapper().mapToMessage(exception, context.l10n);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    context.read<CPAuthCubit>().clearError();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CPAuthCubit, CPAuthState>(
      builder: (BuildContext context, CPAuthState state) {
        return switch (state) {
          CPAuthenticatedState(
            :final session,
            :final biometricsAvailable,
            :final biometricsEnabled,
            :final isBusy,
          ) =>
            CPProfileView(
              session: session,
              biometricsAvailable: biometricsAvailable,
              biometricsEnabled: biometricsEnabled,
              isBusy: isBusy,
              onEnableBiometricTap: () => _onEnableBiometricTap(context),
              onDisableBiometricTap: () => _onDisableBiometricTap(context),
              onLogoutTap: () => _onLogoutTap(context),
              onOpenWidgetbookTap: () => _onOpenWidgetbookTap(context),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
