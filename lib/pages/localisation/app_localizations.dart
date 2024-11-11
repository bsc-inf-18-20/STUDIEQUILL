import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const supportedLocales = [
    Locale('en', ''), // English
    Locale('ny', ''), // Chichewa
  ];

  String getString(String key) {
    switch (locale.languageCode) {
      case 'ny':
        return _chichewaTranslations[key] ?? key;
      case 'en':
      default:
        return _englishTranslations[key] ?? key;
    }
  }

  static const Map<String, String> _englishTranslations = {
    'login_title': 'Login to Your Account',
    'email_label': 'Email',
    'password_label': 'Password',
    'login_button': 'Login',
    'signup_prompt': 'Don\'t have an account? ',
    'signup_button': 'Sign Up',
  };

  static const Map<String, String> _chichewaTranslations = {
    'login_title': 'lembetsan ',
    'email_label': 'Imelo',
    'password_label': 'Pasipoti',
    'login_button': 'Lembani',
    'signup_prompt': 'mulibe ? ',
    'signup_button': 'Kulembetsa',
  };
}
