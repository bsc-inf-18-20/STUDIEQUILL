import 'package:flutter/material.dart';
import 'package:studie/pages/settings/log_out.dart';
import 'delete_account.dart';
import 'our_plans.dart';
import 'help.dart';
import 'like_rate_us.dart';
import 'about_us.dart';
import 'invite.dart';
import 'user_profile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const UserProfile(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildSettingOption(
                    'Our Plans',
                    Icons.assignment,
                    context,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OurPlansPage()),
                    ),
                  ),
                  _buildSettingOption(
                    'Help',
                    Icons.help,
                    context,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpPage()),
                    ),
                  ),
                  _buildSettingOption(
                    'Invite Friends',
                    Icons.person_add,
                    context,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InvitePage()),
                    ),
                  ),
                  _buildSettingOption(
                    'Like or Rate Us',
                    Icons.star,
                    context,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LikeRateUsPage()),
                    ),
                  ),
                  _buildSettingOption(
                    'About Us',
                    Icons.info,
                    context,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutUsPage()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSettingOption(
                    'Delete Account',
                    Icons.delete,
                    context,
                    () => deleteAccount(context),
                    tileColor: Colors.red,
                    textColor: Colors.white,
                  ),
                  _buildSettingOption(
                    'Logout',
                    Icons.logout,
                    context,
                    () => logout(context),
                    tileColor: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build setting options
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

// import 'package:flutter/material.dart';
// import 'package:studie/localisation/app_localisation.dart';
// import 'package:studie/pages/settings/log_out.dart';
// import 'delete_account.dart';
// import 'our_plans.dart';
// import 'help.dart';
// import 'like_rate_us.dart';
// import 'about_us.dart';
// import 'invite.dart';
// import 'user_profile.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppLocalization.of(context)!.translate('settings')),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const UserProfile(),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView(
//                 children: [
//                   _buildSettingOption(
//                     AppLocalization.of(context)!.translate('our_plans'),
//                     Icons.assignment,
//                     context,
//                     () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const OurPlansPage()),
//                     ),
//                   ),
//                   _buildSettingOption(
//                     AppLocalization.of(context)!.translate('help'),
//                     Icons.help,
//                     context,
//                     () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const HelpPage()),
//                     ),
//                   ),
//                   _buildSettingOption(
//                     AppLocalization.of(context)!.translate('invite_friends'),
//                     Icons.person_add,
//                     context,
//                     () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const InvitePage()),
//                     ),
//                   ),
//                   _buildSettingOption(
//                     AppLocalization.of(context)!.translate('like_or_rate_us'),
//                     Icons.star,
//                     context,
//                     () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const LikeRateUsPage()),
//                     ),
//                   ),
//                   _buildSettingOption(
//                     AppLocalization.of(context)!.translate('about_us'),
//                     Icons.info,
//                     context,
//                     () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const AboutUsPage()),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   _buildSettingOption(
//                     AppLocalization.of(context)!.translate('delete_account'),
//                     Icons.delete,
//                     context,
//                     () => deleteAccount(context),
//                     tileColor: Colors.red,
//                     textColor: Colors.white,
//                   ),
//                   _buildSettingOption(
//                     AppLocalization.of(context)!.translate('logout'),
//                     Icons.logout,
//                     context,
//                     () => logout(context),
//                     tileColor: Colors.blue,
//                     textColor: Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Helper to build setting options
//   Widget _buildSettingOption(
//     String title,
//     IconData icon,
//     BuildContext context,
//     VoidCallback onTap, {
//     Color tileColor = Colors.white,
//     Color textColor = Colors.black,
//   }) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         leading: Icon(icon, color: textColor),
//         title: Text(title, style: TextStyle(color: textColor)),
//         tileColor: tileColor,
//         onTap: onTap,
//       ),
//     );
//   }
// }
