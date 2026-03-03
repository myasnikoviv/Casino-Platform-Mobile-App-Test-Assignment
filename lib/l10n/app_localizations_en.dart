// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Casino Platform';

  @override
  String get loginTitle => 'Welcome';

  @override
  String get loginSubtitle => 'Sign in to continue';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get loginButton => 'Login';

  @override
  String get signUpButton => 'Create account';

  @override
  String get signUpLink => 'No account? Sign up';

  @override
  String get loginLink => 'Already have an account? Login';

  @override
  String get showPassword => 'Show';

  @override
  String get hidePassword => 'Hide';

  @override
  String get generatePassword => 'Generate strong password';

  @override
  String get copyPassword => 'Copy password';

  @override
  String get passwordSavedTitle => 'Save your password';

  @override
  String get passwordSavedDescription =>
      'This app has local auth only. Keep this password in a safe place.';

  @override
  String get continueButton => 'Continue';

  @override
  String get enableBiometricTitle => 'Enable one-tap login';

  @override
  String get enableBiometricDescription =>
      'You can use biometrics to avoid password loss issues in local auth.';

  @override
  String get enableBiometric => 'Enable biometrics';

  @override
  String get disableBiometric => 'Disable biometrics';

  @override
  String get loginWithBiometrics => 'Login with biometrics';

  @override
  String get skipForNow => 'Skip for now';

  @override
  String get homeTab => 'Home';

  @override
  String get gamesTab => 'Games';

  @override
  String get profileTab => 'Profile';

  @override
  String get promoTitle1 => 'Daily Tournament';

  @override
  String get promoTitle2 => 'Weekend Cashback';

  @override
  String get promoCta => 'Join now';

  @override
  String get loading => 'Loading...';

  @override
  String get retry => 'Retry';

  @override
  String get playNow => 'Play now';

  @override
  String get provider => 'Provider';

  @override
  String get rtp => 'RTP';

  @override
  String get volatility => 'Volatility';

  @override
  String get memberSince => 'Member since';

  @override
  String get accountId => 'Account ID';

  @override
  String get logout => 'Logout';

  @override
  String get widgetbookTitle => 'Widgetbook';

  @override
  String get openWidgetbook => 'Open Widgetbook';

  @override
  String get settingsHint => 'Developer tools';

  @override
  String get invalidEmail => 'Enter a valid email address.';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters.';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match.';

  @override
  String get emptyField => 'This field is required.';

  @override
  String get invalidCredentials => 'Invalid email or password.';

  @override
  String get emailExists => 'An account with this email already exists.';

  @override
  String get storageError => 'Storage error occurred. Please retry.';

  @override
  String get unexpectedError => 'Something went wrong. Please retry.';

  @override
  String get authRequired => 'Please login to continue.';

  @override
  String get biometricsUnavailable =>
      'Biometrics are not available or not enrolled on this device.';

  @override
  String get biometricsUnavailableStatus => 'Unavailable';

  @override
  String get biometricsNotEnabled =>
      'Biometric login is not enabled for this account.';

  @override
  String get biometricAuthFailed =>
      'Biometric authentication was not completed.';

  @override
  String get categorySlots => 'Slots';

  @override
  String get categoryLive => 'Live Casino';

  @override
  String get categoryTable => 'Table';

  @override
  String get categoryJackpot => 'Jackpot';

  @override
  String get volatilityLow => 'Low';

  @override
  String get volatilityMedium => 'Medium';

  @override
  String get volatilityHigh => 'High';

  @override
  String get gamesLoadError => 'Unable to load games right now.';

  @override
  String get profileHeader => 'Profile';

  @override
  String get notifications => 'Notifications';

  @override
  String get language => 'Language';

  @override
  String get biometricsStatusLabel => 'Biometrics';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get english => 'English';

  @override
  String get themeTokens => 'Theme Tokens';

  @override
  String get typography => 'Typography';

  @override
  String get sharedWidgets => 'Shared Widgets';

  @override
  String get sampleInput => 'Sample input';

  @override
  String get primaryButton => 'Primary Button';

  @override
  String get passwordCopied => 'Password copied';
}
