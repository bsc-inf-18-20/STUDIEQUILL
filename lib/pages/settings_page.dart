// // settings_page.dart
// import 'package:flutter/material.dart';

// class SettingsPage extends StatelessWidget {
//   final bool isDarkMode;
//   final ValueChanged<bool> onThemeChange;

//   const SettingsPage({
//     Key? key,
//     required this.isDarkMode,
//     required this.onThemeChange,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Settings')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               'Settings',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             SwitchListTile(
//               title: const Text('Dark Mode'),
//               value: isDarkMode,
//               onChanged: onThemeChange, // Call the passed callback
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView(
//                 children: [
//                   _buildSettingOption('Our Plans', Icons.assignment, context),
//                   _buildSettingOption(
//                       'Manage Subscription', Icons.subscriptions, context),
//                   _buildSettingOption('Help', Icons.help, context),
//                   _buildSettingOption(
//                       'Invite Friends', Icons.person_add, context),
//                   _buildSettingOption('Like or Rate Us', Icons.star, context),
//                   _buildSettingOption('About Us', Icons.info, context),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSettingOption(
//       String title, IconData icon, BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         leading: Icon(icon),
//         title: Text(title),
//         onTap: () {
//           print('$title tapped'); // Replace with actual functionality
//         },
//       ),
//     );
//   }
// }

// settings_page.dart
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChange;

  const SettingsPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: isDarkMode,
              onChanged: onThemeChange, // Calls the global theme toggle
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildSettingOption('Our Plans', Icons.assignment, context),
                  _buildSettingOption(
                      'Manage Subscription', Icons.subscriptions, context),
                  _buildSettingOption('Help', Icons.help, context),
                  _buildSettingOption(
                      'Invite Friends', Icons.person_add, context),
                  _buildSettingOption('Like or Rate Us', Icons.star, context),
                  _buildSettingOption('About Us', Icons.info, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(
      String title, IconData icon, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          print('$title tapped'); // Replace with actual functionality
        },
      ),
    );
  }
}
