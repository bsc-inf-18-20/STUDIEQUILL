import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:studie/pages/authetication/Login_Page.dart';
import 'package:studie/pages/home/HomePage.dart';
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
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ny', ''), // Chichewa
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // For Material widgets
        GlobalWidgetsLocalizations.delegate, // For generic widgets
        GlobalCupertinoLocalizations.delegate, // For Cupertino widgets
        AppLocalizationDelegate(), // Custom localization delegate
      ],
      locale: _locale,
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      // Use a stream to determine the home page dynamically
      home: const AuthStateHandler(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(
              isDarkMode: false,
              onThemeChange: (value) {},
            ),
      },
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ny'].contains(locale.languageCode);
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

// Dynamically decide which page to show based on authentication state
class AuthStateHandler extends StatelessWidget {
  const AuthStateHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // If user is signed in, navigate to HomePage
          return HomePage(
            isDarkMode: false,
            onThemeChange: (value) {},
          );
        } else {
          // If user is not signed in, navigate to LoginPage
          return const LoginPage();
        }
      },
    );
  }
}
