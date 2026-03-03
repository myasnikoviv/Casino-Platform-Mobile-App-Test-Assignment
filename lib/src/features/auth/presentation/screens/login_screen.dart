import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/core/errors/error_mapper.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/auth/presentation/widgets/auth_error_banner.dart';
import 'package:casino_platform_test/src/features/auth/presentation/widgets/auth_form_validators.dart';
import 'package:casino_platform_test/src/features/auth/presentation/widgets/auth_screen_container.dart';
import 'package:casino_platform_test/src/features/auth/presentation/widgets/auth_title_block.dart';
import 'package:casino_platform_test/src/features/auth/presentation/widgets/password_toggle_button.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/widgets/app_button.dart';
import 'package:casino_platform_test/src/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Login screen for local authentication flow.
class LoginScreen extends StatefulWidget {
  /// Route path for login screen.
  static const String routePath = RoutePaths.login;

  /// Creates [LoginScreen].
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ErrorMapper _errorMapper = ErrorMapper();
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
      AuthFormValidators.validateEmail(_emailController.text);
      AuthFormValidators.validatePassword(_passwordController.text);
      setState(() => _formError = null);
      context.read<AuthCubit>().login(
            _emailController.text,
            _passwordController.text,
          );
    } on AppException catch (error) {
      setState(
          () => _formError = _errorMapper.mapToMessage(error, context.l10n));
    }
  }

  void _onSignUpTap() {
    context.go(RoutePaths.signUp);
  }

  void _togglePassword() {
    setState(() => _passwordVisible = !_passwordVisible);
  }

  void _onBiometricTap() {
    context.read<AuthCubit>().loginWithBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (AuthState previous, AuthState current) =>
          previous.error != current.error,
      listener: (BuildContext context, AuthState state) {
        final AppException? exception = state.error;
        if (exception != null) {
          setState(() {
            _formError = _errorMapper.mapToMessage(exception, context.l10n);
          });
          context.read<AuthCubit>().clearError();
        }
      },
      builder: (BuildContext context, AuthState state) {
        return AuthScreenContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16.h),
              AuthTitleBlock(
                title: context.l10n.text('loginTitle'),
                subtitle: context.l10n.text('loginSubtitle'),
              ),
              SizedBox(height: 24.h),
              if (_formError != null) AuthErrorBanner(message: _formError!),
              if (_formError != null) SizedBox(height: 14.h),
              AppTextField(
                controller: _emailController,
                label: context.l10n.text('emailLabel'),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const <String>[AutofillHints.email],
              ),
              SizedBox(height: 12.h),
              AppTextField(
                controller: _passwordController,
                label: context.l10n.text('passwordLabel'),
                obscureText: !_passwordVisible,
                autofillHints: const <String>[AutofillHints.password],
                suffix: PasswordToggleButton(
                  isVisible: _passwordVisible,
                  showLabel: context.l10n.text('showPassword'),
                  hideLabel: context.l10n.text('hidePassword'),
                  onTap: _togglePassword,
                ),
              ),
              SizedBox(height: 16.h),
              AppButton(
                label: context.l10n.text('loginButton'),
                onPressed: _onLoginTap,
                isLoading: state.isBusy,
              ),
              if (state.biometricsAvailable) SizedBox(height: 10.h),
              if (state.biometricsAvailable)
                AppButton(
                  label: context.l10n.text('enableBiometric'),
                  onPressed: _onBiometricTap,
                  icon: Icons.fingerprint,
                ),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: _onSignUpTap,
                child: Text(context.l10n.text('signUpLink')),
              ),
            ],
          ),
        );
      },
    );
  }
}
