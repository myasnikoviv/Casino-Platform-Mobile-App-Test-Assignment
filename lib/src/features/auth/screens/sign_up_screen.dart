import 'package:casino_platform_test/src/core/errors/app_exception.dart';
import 'package:casino_platform_test/src/core/errors/error_mapper.dart';
import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/utils/password_generator.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/auth/components/auth_error_banner.dart';
import 'package:casino_platform_test/src/features/auth/components/auth_form_validators.dart';
import 'package:casino_platform_test/src/features/auth/components/auth_screen_container.dart';
import 'package:casino_platform_test/src/features/auth/components/auth_title_block.dart';
import 'package:casino_platform_test/src/features/auth/components/password_toggle_button.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/widgets/app_button.dart';
import 'package:casino_platform_test/src/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Registration screen for local account creation.
class CPSignUpScreen extends StatefulWidget {
  /// Route path for sign-up screen.
  static const String routePath = CPRoutePaths.signUp;

  /// Creates [CPSignUpScreen].
  const CPSignUpScreen({super.key});

  @override
  State<CPSignUpScreen> createState() => _CPSignUpScreenState();
}

class _CPSignUpScreenState extends State<CPSignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final CPErrorMapper _errorMapper = CPErrorMapper();

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
    final String generated = CPPasswordGenerator.generate();
    _passwordController.text = generated;
    _confirmController.text = generated;
  }

  Future<void> _onSignUpTap() async {
    try {
      CPAuthFormValidators.validateName(_nameController.text);
      CPAuthFormValidators.validateEmail(_emailController.text);
      CPAuthFormValidators.validatePassword(_passwordController.text);
      CPAuthFormValidators.validatePasswordMatch(
        _passwordController.text,
        _confirmController.text,
      );
      setState(() => _formError = null);

      await context.read<CPAuthCubit>().register(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
          );

      if (!mounted) {
        return;
      }
      if (context.read<CPAuthCubit>().state.status ==
          CPAuthStatus.authenticated) {
        context.goSubRoute(
          CPRoutePaths.passwordReview,
          extra: _passwordController.text,
        );
      }
    } on CPAppException catch (error) {
      setState(
          () => _formError = _errorMapper.mapToMessage(error, context.l10n));
    }
  }

  void _onLoginTap() {
    context.goSubRoute(CPRoutePaths.login);
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
                title: context.l10n.text('signUpButton'),
                subtitle: context.l10n.text('loginSubtitle'),
              ),
              SizedBox(height: 24.h),
              if (_formError != null) CPAuthErrorBanner(message: _formError!),
              if (_formError != null) SizedBox(height: 14.h),
              CPAppTextField(
                controller: _nameController,
                label: context.l10n.text('fullNameLabel'),
                autofillHints: const <String>[AutofillHints.name],
              ),
              SizedBox(height: 12.h),
              CPAppTextField(
                controller: _emailController,
                label: context.l10n.text('emailLabel'),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const <String>[AutofillHints.email],
              ),
              SizedBox(height: 12.h),
              CPAppTextField(
                controller: _passwordController,
                label: context.l10n.text('passwordLabel'),
                obscureText: !_passwordVisible,
                suffix: CPPasswordToggleButton(
                  isVisible: _passwordVisible,
                  showLabel: context.l10n.text('showPassword'),
                  hideLabel: context.l10n.text('hidePassword'),
                  onTap: () =>
                      setState(() => _passwordVisible = !_passwordVisible),
                ),
              ),
              SizedBox(height: 12.h),
              CPAppTextField(
                controller: _confirmController,
                label: context.l10n.text('confirmPasswordLabel'),
                obscureText: !_confirmVisible,
                suffix: CPPasswordToggleButton(
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
              CPAppButton(
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
