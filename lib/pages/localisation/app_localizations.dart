// import 'package:flutter/material.dart';

// class AppLocalizations {
//   AppLocalizations(this.locale);

//   final Locale locale;

//   static AppLocalizations? of(BuildContext context) {
//     return Localizations.of<AppLocalizations>(context, AppLocalizations);
//   }

//   static const supportedLocales = [
//     Locale('en', ''), // English
//     Locale('ny', ''), // Chichewa
//   ];

//   String getString(String key) {
//     switch (locale.languageCode) {
//       case 'en':
//         return _chichewaTranslations[key] ?? key;
//       case 'ny':
//       default:
//         return _englishTranslations[key] ?? key;
//     }
//   }

//   // English translations
//   static const Map<String, String> _englishTranslations = {
//     'settings_title': 'Settings',
//     'dark_mode': 'Dark Mode',
//     'change_language': 'Change Language',
//     'our_plans': 'Our Plans',
//     'help': 'Help',
//     'invite_friends': 'Invite Friends',
//     'like_rate_us': 'Like or Rate Us',
//     'about_us': 'About Us',
//     'delete_account': 'Delete Account',
//     'logout': 'Logout',
//   };

//   // Chichewa translations
//   static const Map<String, String> _chichewaTranslations = {
//     'settings_title': 'Zikhazikiko',
//     'dark_mode': 'Kuwala kwa Mdima',
//     'change_language': 'Sinthani Chinenero',
//     'our_plans': 'Mapulani Athu',
//     'help': 'Thandizo',
//     'invite_friends': 'Itanani Anzanu',
//     'like_rate_us': 'Lembani Kapena Kutipatsa Nyenyezi',
//     'about_us': 'Zambiri za Ife',
//     'delete_account': 'Chotsani Akaunti',
//     'logout': 'Tulukani',
//   };
// }

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

  // Get the localized string based on the current language
  String getString(String key) {
    switch (locale.languageCode) {
      case 'en':
        return _englishTranslations[key] ??
            key; // Return English translations for 'en'
      case 'ny':
      default:
        return _chichewaTranslations[key] ??
            key; // Return Chichewa translations for 'ny'
    }
  }

  // English translations
  static const Map<String, String> _englishTranslations = {
    'settings_title': 'Settings',
    'dark_mode': 'Dark Mode',
    'change_language': 'Change Language',
    'our_plans': 'Our Plans',
    'help': 'Help',
    'invite_friends': 'Invite Friends',
    'like_rate_us': 'Like or Rate Us',
    'about_us': 'About Us',
    'delete_account': 'Delete Account',
    'logout': 'Logout',
  };

  // Chichewa translations
  static const Map<String, String> _chichewaTranslations = {
    'settings_title': 'Zikhazikiko',
    'dark_mode': 'Kuwala kwa Mdima',
    'change_language': 'Sinthani Chinenero',
    'our_plans': 'Mapulani Athu',
    'help': 'Thandizo',
    'invite_friends': 'Itanani Anzanu',
    'like_rate_us': 'Lembani Kapena Kutipatsa Nyenyezi',
    'about_us': 'Zambiri za Ife',
    'delete_account': 'Chotsani Akaunti',
    'logout': 'Tulukani',
  };
}
