import 'package:flutter/material.dart';
import 'package:studie/main.dart'; // For MyApp.setLocale
import 'package:studie/pages/authetication/log_out.dart';
import 'delete_account.dart';
import 'our_plans.dart';
import 'help.dart';
import 'like_rate_us.dart';
import 'about_us.dart';
import 'invite.dart';
import 'user_profile.dart';
import 'package:studie/pages/localisation/app_localizations.dart'; // For localized strings

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChange;

  const SettingsPage({
    super.key,
    this.isDarkMode = false, // Default value for isDarkMode
    this.onThemeChange = _defaultThemeChange, // Default no-op function
  });

  static void _defaultThemeChange(bool value) {
    print('Theme change callback not provided');
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(AppLocalizations.of(context)!.getString('change_language')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  MyApp.setLocale(context, const Locale('en'));
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              ListTile(
                title: const Text('Chichewa'),
                onTap: () {
                  MyApp.setLocale(context, const Locale('ny'));
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context)!; // Get localized strings
    return Scaffold(
      appBar: AppBar(title: Text(localizations.getString('settings_title'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const UserProfile(),
            const SizedBox(height: 20),
            SwitchListTile(
              title: Text(localizations.getString('dark_mode')),
              value: isDarkMode,
              onChanged: onThemeChange,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildSettingOption(
                      localizations.getString('change_language'),
                      Icons.language,
                      context, () {
                    _showLanguageSelectionDialog(context);
                  }),
                  _buildSettingOption(localizations.getString('our_plans'),
                      Icons.assignment, context, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OurPlansPage()),
                    );
                  }),
                  _buildSettingOption(
                      localizations.getString('help'), Icons.help, context, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpPage()),
                    );
                  }),
                  _buildSettingOption(localizations.getString('invite_friends'),
                      Icons.person_add, context, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InvitePage()),
                    );
                  }),
                  _buildSettingOption(localizations.getString('like_rate_us'),
                      Icons.star, context, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LikeRateUsPage()),
                    );
                  }),
                  _buildSettingOption(
                      localizations.getString('about_us'), Icons.info, context,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutUsPage()),
                    );
                  }),
                  const SizedBox(height: 20),
                  _buildSettingOption(localizations.getString('delete_account'),
                      Icons.delete, context, () {
                    deleteAccount(context); // Use the imported function
                  }, tileColor: Colors.red, textColor: Colors.white),
                  _buildSettingOption(
                      localizations.getString('logout'), Icons.logout, context,
                      () {
                    logout(context); // Use the imported function
                  }, tileColor: Colors.blue, textColor: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(
    String title,
    IconData icon,
    BuildContext context,
    VoidCallback onTap, {
    Color tileColor = Colors.white,
    Color textColor = Colors.black,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(title, style: TextStyle(color: textColor)),
        tileColor: tileColor,
        onTap: onTap,
      ),
    );
  }
}
