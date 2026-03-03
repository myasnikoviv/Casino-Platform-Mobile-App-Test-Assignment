import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/core/errors/error_mapper.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/utils/password_generator.dart';
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

/// Registration screen for local account creation.
class SignUpScreen extends StatefulWidget {
  /// Route path for sign-up screen.
  static const String routePath = RoutePaths.signUp;

  /// Creates [SignUpScreen].
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final ErrorMapper _errorMapper = ErrorMapper();

  String? _formError;
  bool _passwordVisible = false;
  bool _confirmVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onGeneratePasswordTap() {
    final String generated = PasswordGenerator.generate();
    _passwordController.text = generated;
    _confirmController.text = generated;
  }

  Future<void> _onSignUpTap() async {
    try {
      AuthFormValidators.validateName(_nameController.text);
      AuthFormValidators.validateEmail(_emailController.text);
      AuthFormValidators.validatePassword(_passwordController.text);
      AuthFormValidators.validatePasswordMatch(
        _passwordController.text,
        _confirmController.text,
      );
      setState(() => _formError = null);

      await context.read<AuthCubit>().register(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
          );

      if (!mounted) {
        return;
      }
      if (context.read<AuthCubit>().state.status == AuthStatus.authenticated) {
        context.go(
          RoutePaths.passwordReview,
          extra: _passwordController.text,
        );
      }
    } on AppException catch (error) {
      setState(
          () => _formError = _errorMapper.mapToMessage(error, context.l10n));
    }
  }

  void _onLoginTap() {
    context.go(RoutePaths.login);
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
                title: context.l10n.text('signUpButton'),
                subtitle: context.l10n.text('loginSubtitle'),
              ),
              SizedBox(height: 24.h),
              if (_formError != null) AuthErrorBanner(message: _formError!),
              if (_formError != null) SizedBox(height: 14.h),
              AppTextField(
                controller: _nameController,
                label: context.l10n.text('fullNameLabel'),
                autofillHints: const <String>[AutofillHints.name],
              ),
              SizedBox(height: 12.h),
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
                suffix: PasswordToggleButton(
                  isVisible: _passwordVisible,
                  showLabel: context.l10n.text('showPassword'),
                  hideLabel: context.l10n.text('hidePassword'),
                  onTap: () =>
                      setState(() => _passwordVisible = !_passwordVisible),
                ),
              ),
              SizedBox(height: 12.h),
              AppTextField(
                controller: _confirmController,
                label: context.l10n.text('confirmPasswordLabel'),
                obscureText: !_confirmVisible,
                suffix: PasswordToggleButton(
                  isVisible: _confirmVisible,
                  showLabel: context.l10n.text('showPassword'),
                  hideLabel: context.l10n.text('hidePassword'),
                  onTap: () =>
                      setState(() => _confirmVisible = !_confirmVisible),
                ),
              ),
              SizedBox(height: 8.h),
              TextButton(
                onPressed: _onGeneratePasswordTap,
                child: Text(context.l10n.text('generatePassword')),
              ),
              SizedBox(height: 8.h),
              AppButton(
                label: context.l10n.text('signUpButton'),
                onPressed: _onSignUpTap,
                isLoading: state.isBusy,
              ),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: _onLoginTap,
                child: Text(context.l10n.text('loginLink')),
              ),
            ],
          ),
        );
      },
    );
  }
}
