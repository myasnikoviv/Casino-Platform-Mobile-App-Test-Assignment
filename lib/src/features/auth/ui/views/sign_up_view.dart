import 'package:casino_platform_test/src/core/exceptions/app_exception.dart';
import 'package:casino_platform_test/src/core/exceptions/error_mapper.dart';
import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/core/utils/password_generator.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/auth_error_banner.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/auth_form_validators.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/auth_screen_container.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/auth_title_block.dart';
import 'package:casino_platform_test/src/features/auth/ui/components/password_toggle_button.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/login_screen.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/password_review_screen.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/ui/app_button.dart';
import 'package:casino_platform_test/src/shared/ui/app_text_button.dart';
import 'package:casino_platform_test/src/shared/ui/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Sign-up view with form and local UI state.
class CPSignUpView extends StatefulWidget {
  /// Creates [CPSignUpView].
  const CPSignUpView({super.key});

  @override
  State<CPSignUpView> createState() => _CPSignUpViewState();
}

class _CPSignUpViewState extends State<CPSignUpView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final CPErrorMapper _errorMapper = CPErrorMapper();

  String? _domainError;
  bool _passwordVisible = false;
  bool _confirmVisible = false;
  bool _showValidationErrors = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
    _confirmController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _nameController.removeListener(_onFieldChanged);
    _emailController.removeListener(_onFieldChanged);
    _passwordController.removeListener(_onFieldChanged);
    _confirmController.removeListener(_onFieldChanged);
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {
      _showValidationErrors = true;
      _domainError = null;
    });
  }

  List<String> _collectValidationErrors(BuildContext context) {
    final List<String> errors = <String>[];

    try {
      CPAuthFormValidators.validateName(_nameController.text);
    } on CPAppException catch (error) {
      errors.add(
        '${context.l10n.fullNameLabel}: ${_errorMapper.mapToMessage(error, context.l10n)}',
      );
    }

    try {
      CPAuthFormValidators.validateEmail(_emailController.text);
    } on CPAppException catch (error) {
      errors.add(
        '${context.l10n.emailLabel}: ${_errorMapper.mapToMessage(error, context.l10n)}',
      );
    }

    try {
      CPAuthFormValidators.validatePassword(_passwordController.text);
    } on CPAppException catch (error) {
      errors.add(
        '${context.l10n.passwordLabel}: ${_errorMapper.mapToMessage(error, context.l10n)}',
      );
    }

    try {
      CPAuthFormValidators.validatePasswordMatch(
        _passwordController.text,
        _confirmController.text,
      );
    } on CPAppException catch (error) {
      errors.add(_errorMapper.mapToMessage(error, context.l10n));
    }

    return errors;
  }

  void _onGeneratePasswordTap() {
    final String generated = CPPasswordGenerator.generate();
    _passwordController.text = generated;
    _confirmController.text = generated;
  }

  Future<void> _onSignUpTap() async {
    setState(() {
      _showValidationErrors = true;
      _domainError = null;
    });

    final List<String> validationErrors = _collectValidationErrors(context);
    if (validationErrors.isNotEmpty) {
      return;
    }

    try {
      await context.read<CPAuthCubit>().register(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
          );

      if (!mounted) {
        return;
      }
      if (context.read<CPAuthCubit>().state is CPAuthenticatedState) {
        context.goSubRoute(
          CPPasswordReviewScreen.routePath,
          extra: _passwordController.text,
        );
      }
    } on CPAppException catch (error) {
      setState(
          () => _domainError = _errorMapper.mapToMessage(error, context.l10n));
    }
  }

  void _onLoginTap() {
    context.goSubRoute(CPLoginScreen.routePath);
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
            _domainError = _errorMapper.mapToMessage(exception, context.l10n);
          });
          context.read<CPAuthCubit>().clearError();
        }
      },
      builder: (BuildContext context, CPAuthState state) {
        final List<String> allErrors = <String>{
          if (_showValidationErrors) ..._collectValidationErrors(context),
          if (_domainError != null) _domainError!,
        }.toList();

        return CPAuthScreenContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16.h),
              CPAuthTitleBlock(
                title: context.l10n.signUpButton,
                subtitle: context.l10n.loginSubtitle,
              ),
              SizedBox(height: 24.h),
              if (allErrors.isNotEmpty) CPAuthErrorBanner(messages: allErrors),
              if (allErrors.isNotEmpty) SizedBox(height: 14.h),
              CPAppTextField(
                controller: _nameController,
                label: context.l10n.fullNameLabel,
                autofillHints: const <String>[AutofillHints.name],
              ),
              SizedBox(height: 12.h),
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
                suffix: CPPasswordToggleButton(
                  isVisible: _passwordVisible,
                  showLabel: context.l10n.showPassword,
                  hideLabel: context.l10n.hidePassword,
                  onTap: () =>
                      setState(() => _passwordVisible = !_passwordVisible),
                ),
              ),
              SizedBox(height: 12.h),
              CPAppTextField(
                controller: _confirmController,
                label: context.l10n.confirmPasswordLabel,
                obscureText: !_confirmVisible,
                suffix: CPPasswordToggleButton(
                  isVisible: _confirmVisible,
                  showLabel: context.l10n.showPassword,
                  hideLabel: context.l10n.hidePassword,
                  onTap: () =>
                      setState(() => _confirmVisible = !_confirmVisible),
                ),
              ),
              SizedBox(height: 8.h),
              CPAppTextButton(
                onPressed: _onGeneratePasswordTap,
                label: context.l10n.generatePassword,
              ),
              SizedBox(height: 8.h),
              CPAppButton(
                label: context.l10n.signUpButton,
                onPressed: _onSignUpTap,
                isLoading: state.isBusy,
              ),
              SizedBox(height: 10.h),
              CPAppTextButton(
                onPressed: _onLoginTap,
                label: context.l10n.loginLink,
              ),
            ],
          ),
        );
      },
    );
  }
}
