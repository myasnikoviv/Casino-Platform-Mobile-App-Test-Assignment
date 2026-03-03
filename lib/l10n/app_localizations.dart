import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Casino Platform'**
  String get appTitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signUpButton;

  /// No description provided for @signUpLink.
  ///
  /// In en, this message translates to:
  /// **'No account? Sign up'**
  String get signUpLink;

  /// No description provided for @loginLink.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Login'**
  String get loginLink;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hidePassword;

  /// No description provided for @generatePassword.
  ///
  /// In en, this message translates to:
  /// **'Generate strong password'**
  String get generatePassword;

  /// No description provided for @copyPassword.
  ///
  /// In en, this message translates to:
  /// **'Copy password'**
  String get copyPassword;

  /// No description provided for @passwordSavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Save your password'**
  String get passwordSavedTitle;

  /// No description provided for @passwordSavedDescription.
  ///
  /// In en, this message translates to:
  /// **'This app has local auth only. Keep this password in a safe place.'**
  String get passwordSavedDescription;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @enableBiometricTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable one-tap login'**
  String get enableBiometricTitle;

  /// No description provided for @enableBiometricDescription.
  ///
  /// In en, this message translates to:
  /// **'You can use biometrics to avoid password loss issues in local auth.'**
  String get enableBiometricDescription;

  /// No description provided for @enableBiometric.
  ///
  /// In en, this message translates to:
  /// **'Enable biometrics'**
  String get enableBiometric;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get skipForNow;

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @gamesTab.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get gamesTab;

  /// No description provided for @profileTab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// No description provided for @promoTitle1.
  ///
  /// In en, this message translates to:
  /// **'Daily Tournament'**
  String get promoTitle1;

  /// No description provided for @promoTitle2.
  ///
  /// In en, this message translates to:
  /// **'Weekend Cashback'**
  String get promoTitle2;

  /// No description provided for @promoCta.
  ///
  /// In en, this message translates to:
  /// **'Join now'**
  String get promoCta;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @playNow.
  ///
  /// In en, this message translates to:
  /// **'Play now'**
  String get playNow;

  /// No description provided for @provider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get provider;

  /// No description provided for @rtp.
  ///
  /// In en, this message translates to:
  /// **'RTP'**
  String get rtp;

  /// No description provided for @volatility.
  ///
  /// In en, this message translates to:
  /// **'Volatility'**
  String get volatility;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since'**
  String get memberSince;

  /// No description provided for @accountId.
  ///
  /// In en, this message translates to:
  /// **'Account ID'**
  String get accountId;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @widgetbookTitle.
  ///
  /// In en, this message translates to:
  /// **'Widgetbook'**
  String get widgetbookTitle;

  /// No description provided for @openWidgetbook.
  ///
  /// In en, this message translates to:
  /// **'Open Widgetbook'**
  String get openWidgetbook;

  /// No description provided for @settingsHint.
  ///
  /// In en, this message translates to:
  /// **'Developer tools'**
  String get settingsHint;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters.'**
  String get passwordTooShort;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsDoNotMatch;

  /// No description provided for @emptyField.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get emptyField;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get invalidCredentials;

  /// No description provided for @emailExists.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists.'**
  String get emailExists;

  /// No description provided for @storageError.
  ///
  /// In en, this message translates to:
  /// **'Storage error occurred. Please retry.'**
  String get storageError;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please retry.'**
  String get unexpectedError;

  /// No description provided for @authRequired.
  ///
  /// In en, this message translates to:
  /// **'Please login to continue.'**
  String get authRequired;

  /// No description provided for @categorySlots.
  ///
  /// In en, this message translates to:
  /// **'Slots'**
  String get categorySlots;

  /// No description provided for @categoryLive.
  ///
  /// In en, this message translates to:
  /// **'Live Casino'**
  String get categoryLive;

  /// No description provided for @categoryTable.
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get categoryTable;

  /// No description provided for @categoryJackpot.
  ///
  /// In en, this message translates to:
  /// **'Jackpot'**
  String get categoryJackpot;

  /// No description provided for @volatilityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get volatilityLow;

  /// No description provided for @volatilityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get volatilityMedium;

  /// No description provided for @volatilityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get volatilityHigh;

  /// No description provided for @gamesLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load games right now.'**
  String get gamesLoadError;

  /// No description provided for @profileHeader.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileHeader;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @themeTokens.
  ///
  /// In en, this message translates to:
  /// **'Theme Tokens'**
  String get themeTokens;

  /// No description provided for @sharedWidgets.
  ///
  /// In en, this message translates to:
  /// **'Shared Widgets'**
  String get sharedWidgets;

  /// No description provided for @sampleInput.
  ///
  /// In en, this message translates to:
  /// **'Sample input'**
  String get sampleInput;

  /// No description provided for @primaryButton.
  ///
  /// In en, this message translates to:
  /// **'Primary Button'**
  String get primaryButton;

  /// No description provided for @passwordCopied.
  ///
  /// In en, this message translates to:
  /// **'Password copied'**
  String get passwordCopied;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
