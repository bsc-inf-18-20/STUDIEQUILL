// // ignore: file_names
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//   bool _isDarkMode = false; // State variable for dark mode

//   // Method to handle bottom nav item taps
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   // Method to toggle theme
//   void _toggleTheme(bool value) {
//     setState(() {
//       _isDarkMode = value; // Update the dark mode state
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: _isDarkMode
//           ? ThemeData.dark() // Dark theme
//           : ThemeData.light(), // Light theme
//       home: Scaffold(
//         appBar: AppBar(
//             // title: const Text('Home Page'),
//             ),
//         body: _selectedIndex == 5 // If 'Settings' is selected
//             ? SettingsPage(
//                 isDarkMode: _isDarkMode,
//                 onThemeChange: _toggleTheme,
//               )
//             : _buildHomePage(), // Show Home Page for other selections

//         // Bottom navigation bar
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.list_alt),
//               label: 'Records',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.folder),
//               label: 'Files',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.note),
//               label: 'Notes',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.work),
//               label: 'Workspace',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'Settings',
//             ),
//           ],
//           type: BottomNavigationBarType.fixed,
//         ),
//       ),
//     );
//   }

//   Widget _buildHomePage() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: GridView.count(
//         crossAxisCount: 2,
//         crossAxisSpacing: 16.0,
//         mainAxisSpacing: 16.0,
//         children: [
//           _buildRoundedBox('Record', Icons.mic, Colors.blue),
//           _buildRoundedBox('Pick a File', Icons.file_copy, Colors.green),
//           _buildRoundedBox('From URL', Icons.link, Colors.orange),
//           _buildRoundedBox('Share File', Icons.share, Colors.red),
//         ],
//       ),
//     );
//   }

//   Widget _buildRoundedBox(String title, IconData icon, Color color) {
//     return GestureDetector(
//       onTap: () {
//         // Handle tap if needed
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.2),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 50, color: color),
//             const SizedBox(height: 10),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // New SettingsPage Widget
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
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Text(
//             'Settings',
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           SwitchListTile(
//             title: const Text('Dark Mode'),
//             value: isDarkMode,
//             onChanged: onThemeChange, // Call the passed callback
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: ListView(
//               children: [
//                 _buildSettingOption('Our Plans', Icons.assignment, context),
//                 _buildSettingOption(
//                     'Manage Subscription', Icons.subscriptions, context),
//                 _buildSettingOption('Help', Icons.help, context),
//                 _buildSettingOption(
//                     'Invite Friends', Icons.person_add, context),
//                 _buildSettingOption('Like or Rate Us', Icons.star, context),
//                 _buildSettingOption('About Us', Icons.info, context),
//               ],
//             ),
//           ),
//         ],
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
//           // Handle the tap for each setting option here
//           // You can navigate to new pages or show dialogs as needed
//           print('$title tapped'); // Replace with actual functionality
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isDarkMode = false; // State variable for dark mode

  // Define a map of colors for easy customization
  final Map<String, Color> _colorScheme = {
    'record': const Color.fromARGB(255, 153, 154, 155),
    'file': const Color.fromARGB(255, 153, 154, 155),
    'url': const Color.fromARGB(255, 153, 154, 155),
    'share': const Color.fromARGB(255, 153, 154, 155),
  };

  // Method to handle bottom nav item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Method to toggle theme
  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value; // Update the dark mode state
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark() // Dark theme
          : ThemeData.light(), // Light theme
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: _selectedIndex == 5 // If 'Settings' is selected
            ? SettingsPage(
                isDarkMode: _isDarkMode,
                onThemeChange: _toggleTheme,
              )
            : _buildHomePage(), // Show Home Page for other selections

        // Bottom navigation bar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Records',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              label: 'Files',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'Workspace',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildHomePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildRoundedBox('Record', Icons.mic, _colorScheme['record']!),
          _buildRoundedBox(
              'Pick a File', Icons.file_copy, _colorScheme['file']!),
          _buildRoundedBox('From URL', Icons.link, _colorScheme['url']!),
          _buildRoundedBox('Share File', Icons.share, _colorScheme['share']!),
        ],
      ),
    );
  }

  Widget _buildRoundedBox(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle tap if needed
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// New SettingsPage Widget
class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChange;

  const SettingsPage({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            onChanged: onThemeChange, // Call the passed callback
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
          // Handle the tap for each setting option here
          // You can navigate to new pages or show dialogs as needed
          print('$title tapped'); // Replace with actual functionality
        },
      ),
    );
  }
}
