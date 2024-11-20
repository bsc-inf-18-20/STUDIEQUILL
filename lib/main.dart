// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:studie/pages/authetication/Login_Page.dart';
// import 'package:studie/pages/localisation/app_localizations.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   try {
//     await Firebase.initializeApp();
//   } catch (e) {
//     print('Firebase initialization error: $e');
//   }

//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   static void setLocale(BuildContext context, Locale locale) {
//     final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
//     state?.setLocale(locale);
//   }

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Locale _locale = const Locale('en'); // Default locale is English

//   void setLocale(Locale locale) {
//     setState(() {
//       _locale = locale;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Studie APP',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // List of supported locales
//       supportedLocales: const [
//         Locale('en', ''), // English
//         Locale('ny', ''), // Chichewa
//       ],
//       // Localization delegates
//       localizationsDelegates: const [
//         GlobalMaterialLocalizations.delegate, // For Material widgets
//         GlobalWidgetsLocalizations.delegate, // For generic widgets
//         GlobalCupertinoLocalizations.delegate, // For Cupertino widgets
//         AppLocalizationDelegate(), // Custom localization delegate
//       ],
//       // Sets the current locale
//       locale: _locale,
//       // Fallback if localization isn't found
//       localeResolutionCallback:
//           (Locale? locale, Iterable<Locale> supportedLocales) {
//         if (locale == null) {
//           return supportedLocales.first; // Default to first supported locale
//         }
//         for (final supportedLocale in supportedLocales) {
//           if (supportedLocale.languageCode == locale.languageCode &&
//               supportedLocale.countryCode == locale.countryCode) {
//             return supportedLocale;
//           }
//         }
//         return supportedLocales.first;
//       },
//       home: const LoginPage(), // Initial screen
//     );
//   }
// }

// class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
//   const AppLocalizationDelegate();

//   @override
//   bool isSupported(Locale locale) {
//     return ['en', 'ny'].contains(locale.languageCode); // Supported languages
//   }

//   @override
//   Future<AppLocalizations> load(Locale locale) {
//     return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
//   }

//   @override
//   bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
//     return false;
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:studie/pages/authetication/Login_Page.dart';
import 'package:studie/pages/localisation/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // Default locale is English

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studie APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // List of supported locales
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ny', ''), // Chichewa
      ],
      // Localization delegates
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // For Material widgets
        GlobalWidgetsLocalizations.delegate, // For generic widgets
        GlobalCupertinoLocalizations.delegate, // For Cupertino widgets
        AppLocalizationDelegate(), // Custom localization delegate
      ],
      // Sets the current locale
      locale: _locale,
      // Fallback if localization isn't found
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          return supportedLocales.first; // Default to first supported locale
        }
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: const LoginPage(), // Initial screen
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ny'].contains(locale.languageCode); // Supported languages
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
