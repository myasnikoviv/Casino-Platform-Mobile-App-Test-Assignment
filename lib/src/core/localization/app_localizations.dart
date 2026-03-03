import 'package:flutter/material.dart';

/// A lightweight localization provider for the assignment scope.
class AppLocalizations {
  /// Creates localized resources for a locale.
  const AppLocalizations(this.locale);

  /// Locale currently used by this localization instance.
  final Locale locale;

  /// Accessor for localization from widget context.
  static AppLocalizations of(BuildContext context) {
    final AppLocalizations? localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations);
    return localizations ?? const AppLocalizations(Locale('en'));
  }

  /// Delegate registration for [MaterialApp].
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const Map<String, String> _en = <String, String>{
    'appTitle': 'Casino Platform',
    'loginTitle': 'Welcome back',
    'loginSubtitle': 'Sign in to continue',
    'emailLabel': 'Email',
    'passwordLabel': 'Password',
    'fullNameLabel': 'Full name',
    'confirmPasswordLabel': 'Confirm password',
    'loginButton': 'Login',
    'signUpButton': 'Create account',
    'signUpLink': 'No account? Sign up',
    'loginLink': 'Already have an account? Login',
    'showPassword': 'Show',
    'hidePassword': 'Hide',
    'generatePassword': 'Generate strong password',
    'copyPassword': 'Copy password',
    'passwordSavedTitle': 'Save your password',
    'passwordSavedDescription':
        'This app has local auth only. Keep this password in a safe place.',
    'continueButton': 'Continue',
    'enableBiometricTitle': 'Enable one-tap login',
    'enableBiometricDescription':
        'You can use biometrics to avoid password loss issues in local auth.',
    'enableBiometric': 'Enable biometrics',
    'skipForNow': 'Skip for now',
    'homeTab': 'Home',
    'gamesTab': 'Games',
    'profileTab': 'Profile',
    'promoTitle1': 'Daily Tournament',
    'promoTitle2': 'Weekend Cashback',
    'promoCta': 'Join now',
    'loading': 'Loading...',
    'retry': 'Retry',
    'playNow': 'Play now',
    'provider': 'Provider',
    'rtp': 'RTP',
    'volatility': 'Volatility',
    'memberSince': 'Member since',
    'accountId': 'Account ID',
    'logout': 'Logout',
    'widgetbookTitle': 'Widgetbook',
    'openWidgetbook': 'Open Widgetbook',
    'settingsHint': 'Developer tools',
    'invalidEmail': 'Enter a valid email address.',
    'passwordTooShort': 'Password must be at least 8 characters.',
    'passwordsDoNotMatch': 'Passwords do not match.',
    'emptyField': 'This field is required.',
    'invalidCredentials': 'Invalid email or password.',
    'emailExists': 'An account with this email already exists.',
    'storageError': 'Storage error occurred. Please retry.',
    'unexpectedError': 'Something went wrong. Please retry.',
    'authRequired': 'Please login to continue.',
    'categorySlots': 'Slots',
    'categoryLive': 'Live Casino',
    'categoryTable': 'Table',
    'categoryJackpot': 'Jackpot',
    'volatilityLow': 'Low',
    'volatilityMedium': 'Medium',
    'volatilityHigh': 'High',
    'gamesLoadError': 'Unable to load games right now.',
    'profileHeader': 'Profile',
    'notifications': 'Notifications',
    'language': 'Language',
    'enabled': 'Enabled',
    'english': 'English',
    'themeTokens': 'Theme Tokens',
    'sharedWidgets': 'Shared Widgets',
    'sampleInput': 'Sample input',
    'primaryButton': 'Primary Button',
    'passwordCopied': 'Password copied',
  };

  /// Returns localized text by [key].
  String text(String key) {
    return _en[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
