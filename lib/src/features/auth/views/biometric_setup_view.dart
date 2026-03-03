import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/auth/entities/biometric_setup_view_model.dart';
import 'package:casino_platform_test/src/features/auth/components/auth_screen_container.dart';
import 'package:casino_platform_test/src/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Pure biometric setup view that renders content from [CPBiometricSetupViewModel].
class CPBiometricSetupView extends StatelessWidget {
  /// Creates [CPBiometricSetupView].
  const CPBiometricSetupView({
    required this.viewModel,
    required this.onEnableTap,
    required this.onSkipTap,
    super.key,
  });

  /// View model with display-ready strings and flags.
  final CPBiometricSetupViewModel viewModel;

  /// Enable action callback.
  final VoidCallback? onEnableTap;

  /// Skip action callback.
  final VoidCallback onSkipTap;

  @override
  Widget build(BuildContext context) {
    return CPAuthScreenContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20.h),
          Text(viewModel.title, style: CPAppTextStyles.h1),
          SizedBox(height: 10.h),
          Text(viewModel.description, style: CPAppTextStyles.body),
          SizedBox(height: 20.h),
          CPAppButton(
            label: viewModel.enableLabel,
            onPressed: onEnableTap,
            icon: Icons.fingerprint,
            isLoading: viewModel.isLoading,
          ),
          SizedBox(height: 10.h),
          CPAppButton(
            label: viewModel.skipLabel,
            onPressed: onSkipTap,
          ),
        ],
      ),
    );
  }
}
