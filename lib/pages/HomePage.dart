// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light(), // Default light theme
//       darkTheme: ThemeData.dark(), // Dark theme
//       home: const HomePage(), // Main app entry point
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//   bool _isDarkMode = false; // State variable for dark mode

//   // Define a map of colors for easy customization
//   final Map<String, Color> _colorScheme = {
//     'record': const Color.fromARGB(255, 51, 124, 112),
//     'file': const Color.fromARGB(255, 51, 124, 112),
//     'url': const Color.fromARGB(255, 51, 124, 112),
//     'share': const Color.fromARGB(255, 51, 124, 112),
//   };

//   // Method to handle bottom nav item taps and navigation
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     switch (index) {
//       case 1:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const RecordsPage()),
//         );
//         break;
//       case 2:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const FilesPage()),
//         );
//         break;
//       case 3:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const NotesPage()),
//         );
//         break;
//       case 4:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const WorkspacePage()),
//         );
//         break;
//       case 5:
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SettingsPage(
//               isDarkMode: _isDarkMode,
//               onThemeChange: _toggleTheme,
//             ),
//           ),
//         );
//         break;
//       default:
//         break;
//     }
//   }

//   // Method to toggle theme
//   void _toggleTheme(bool value) {
//     setState(() {
//       _isDarkMode = value; // Update the dark mode state
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home"),
//       ),
//       body: _buildHomePage(context), // Show Home Page for selection

//       // Bottom navigation bar
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list_alt),
//             label: 'Records',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.folder),
//             label: 'Files',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.note),
//             label: 'Notes',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work),
//             label: 'Workspace',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         type: BottomNavigationBarType.fixed,
//       ),
//     );
//   }

//   Widget _buildHomePage(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: GridView.count(
//         crossAxisCount: 2,
//         crossAxisSpacing: 16.0,
//         mainAxisSpacing: 16.0,
//         children: [
//           _buildRoundedBox('Record', Icons.mic, _colorScheme['record']!,
//               context, const RecordsPage()),
//           _buildRoundedBox('Pick a File', Icons.file_copy,
//               _colorScheme['file']!, context, const FilesPage()),
//           _buildRoundedBox('From URL', Icons.link, _colorScheme['url']!,
//               context, const NotesPage()),
//           _buildRoundedBox('Share File', Icons.share, _colorScheme['share']!,
//               context, const WorkspacePage()),
//         ],
//       ),
//     );
//   }

//   Widget _buildRoundedBox(String title, IconData icon, Color color,
//       BuildContext context, Widget page) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => page), // Navigate to corresponding page
//         );
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

// // Pages for Records, Files, Notes, and Workspace
// class RecordsPage extends StatelessWidget {
//   const RecordsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Records')),
//       body: const Center(child: Text('This is the Records Page')),
//     );
//   }
// }

// class FilesPage extends StatelessWidget {
//   const FilesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Files')),
//       body: const Center(child: Text('This is the Files Page')),
//     );
//   }
// }

// class NotesPage extends StatelessWidget {
//   const NotesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Notes')),
//       body: const Center(child: Text('This is the Notes Page')),
//     );
//   }
// }

// class WorkspacePage extends StatelessWidget {
//   const WorkspacePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Workspace')),
//       body: const Center(child: Text('This is the Workspace Page')),
//     );
//   }
// }

// // Settings Page
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

// home_page.dart
import 'package:flutter/material.dart';
import 'records_page.dart';
import 'files_page.dart';
import 'notes_page.dart';
import 'workspace_page.dart';
import 'settings_page.dart';

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
    'record': const Color.fromARGB(255, 51, 124, 112),
    'file': const Color.fromARGB(255, 51, 124, 112),
    'url': const Color.fromARGB(255, 51, 124, 112),
    'share': const Color.fromARGB(255, 51, 124, 112),
  };

  // Method to handle bottom nav item taps and navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecordsPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FilesPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotesPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WorkspacePage()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsPage(
              isDarkMode: _isDarkMode,
              onThemeChange: _toggleTheme,
            ),
          ),
        );
        break;
      default:
        break;
    }
  }

  // Method to toggle theme
  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value; // Update the dark mode state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: _buildHomePage(context), // Show Home Page for selection

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
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildRoundedBox('Record', Icons.mic, _colorScheme['record']!,
              context, const RecordsPage()),
          _buildRoundedBox('Pick a File', Icons.file_copy,
              _colorScheme['file']!, context, const FilesPage()),
          _buildRoundedBox('From URL', Icons.link, _colorScheme['url']!,
              context, const NotesPage()),
          _buildRoundedBox('Share File', Icons.share, _colorScheme['share']!,
              context, const WorkspacePage()),
        ],
      ),
    );
  }

  Widget _buildRoundedBox(String title, IconData icon, Color color,
      BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => page), // Navigate to corresponding page
        );
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
