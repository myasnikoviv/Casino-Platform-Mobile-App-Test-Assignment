import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/core/exceptions/error_mapper.dart';
import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/auth_error_banner.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/auth_form_validators.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/auth_screen_container.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/auth_title_block.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/password_toggle_button.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/sign_up_screen.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/app_button.dart';
import 'package:casino_platform_test/src/shared/ui/app_text_button.dart';
import 'package:casino_platform_test/src/shared/ui/app_text_field.dart';
import 'package:casino_platform_test/src/shared/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Login view with form and local UI state.
class CPLoginView extends StatefulWidget {
  /// Creates [CPLoginView].
  const CPLoginView({super.key});

  @override
  State<CPLoginView> createState() => _CPLoginViewState();
}

class _CPLoginViewState extends State<CPLoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final CPErrorMapper _errorMapper = CPErrorMapper();
  String? _formError;
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginTap() {
    try {
      CPAuthFormValidators.validateEmail(_emailController.text);
      CPAuthFormValidators.validatePassword(_passwordController.text);
      setState(() => _formError = null);
      context.read<CPAuthCubit>().login(
            _emailController.text,
            _passwordController.text,
          );
    } on CPAppException catch (error) {
      setState(
          () => _formError = _errorMapper.mapToMessage(error, context.l10n));
    }
  }

  void _onSignUpTap() {
    context.goSubRoute(CPSignUpScreen.routePath);
  }

  void _togglePassword() {
    setState(() => _passwordVisible = !_passwordVisible);
  }

  void _onBiometricTap() {
    context.read<CPAuthCubit>().loginWithBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CPAuthCubit, CPAuthState>(
      listenWhen: (CPAuthState previous, CPAuthState current) =>
          previous.error != current.error,
      listener: (BuildContext context, CPAuthState state) {
        final CPAppException? exception = state.error;
        if (exception != null) {
          setState(() {
            _formError = _errorMapper.mapToMessage(exception, context.l10n);
          });
          context.read<CPAuthCubit>().clearError();
        }
      },
      builder: (BuildContext context, CPAuthState state) {
        return CPAuthScreenContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16.h),
              CPAuthTitleBlock(
                title: context.l10n.loginTitle,
                subtitle: context.l10n.loginSubtitle,
              ),
              SizedBox(height: 24.h),
              if (_formError != null) CPAuthErrorBanner(message: _formError!),
              if (_formError != null) SizedBox(height: 14.h),
              CPAppTextField(
                controller: _emailController,
                label: context.l10n.emailLabel,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const <String>[AutofillHints.email],
              ),
              SizedBox(height: 12.h),
              CPAppTextField(
                controller: _passwordController,
                label: context.l10n.passwordLabel,
                obscureText: !_passwordVisible,
                autofillHints: const <String>[AutofillHints.password],
                suffix: CPPasswordToggleButton(
                  isVisible: _passwordVisible,
                  showLabel: context.l10n.showPassword,
                  hideLabel: context.l10n.hidePassword,
                  onTap: _togglePassword,
                ),
              ),
              SizedBox(height: 16.h),
              CPAppButton(
                label: context.l10n.loginButton,
                onPressed: _onLoginTap,
                isLoading: state.isBusy,
              ),
              if (state.biometricsAvailable && state.biometricsEnabled)
                SizedBox(height: 10.h),
              if (state.biometricsAvailable && state.biometricsEnabled)
                CPAppButton(
                  label: context.l10n.loginWithBiometrics,
                  onPressed: _onBiometricTap,
                  icon: CPIconType.fingerprint,
                ),
              SizedBox(height: 10.h),
              CPAppTextButton(
                onPressed: _onSignUpTap,
                label: context.l10n.signUpLink,
              ),
            ],
          ),
        );
      },
    );
  }
}
