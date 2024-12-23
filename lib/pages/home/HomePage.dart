// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:studie/pages/audio/audio_text.dart';
// import 'package:studie/pages/audio/recordings.dart';
// import 'package:studie/pages/authetication/Login_Page.dart';
// import 'package:studie/pages/file%20picker/pick_file_page.dart.dart';
// import 'package:studie/pages/home/UrlInputPage.dart';
// import 'package:studie/pages/home/files_page.dart';
// import 'package:studie/pages/home/share_file.dart';
// import 'package:studie/pages/settings/settings_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//   bool _isDarkMode = false; // Tracks the theme mode

//   final Map<String, Color> _colorScheme = {
//     'record': const Color(0xFF673AB6),
//     'file': const Color(0xFF673AB6),
//     'url': const Color(0xFF673AB6),
//     'share': const Color(0xFF673AB6),
//   };

//   final List<Widget> _pages = [
//     const AudioText(),
//     const RecordsPage(),
//     const FilesPage(),
//     const SettingsPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _toggleTheme() {
//     setState(() {
//       _isDarkMode = !_isDarkMode;
//     });
//   }

//   Future<void> _logout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Logout failed: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: _isDarkMode
//           ? ThemeData.dark().copyWith(primaryColor: _colorScheme['record'])
//           : ThemeData.light().copyWith(primaryColor: _colorScheme['record']),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "Studiequil",
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 _isDarkMode ? Icons.dark_mode : Icons.light_mode,
//                 color: Colors.white,
//               ),
//               onPressed: _toggleTheme, // Toggles the theme
//             ),
//             IconButton(
//               icon: const Icon(Icons.logout, color: Colors.white),
//               onPressed: _logout,
//             ),
//           ],
//           backgroundColor: _colorScheme['record'],
//         ),
//         body: _buildBody(),
//         bottomNavigationBar: _buildBottomNavigationBar(),
//       ),
//     );
//   }

//   BottomNavigationBar _buildBottomNavigationBar() => BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Recordings'),
//           BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Files'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.settings), label: 'Settings'),
//         ],
//         selectedItemColor: _colorScheme['record'],
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//       );

//   Widget _buildBody() {
//     if (_selectedIndex == 0) {
//       // Display GridView for the Home page
//       return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: GridView.count(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16.0,
//             mainAxisSpacing: 16.0,
//             childAspectRatio: 1.0, // Ensuring the grid items are square-shaped
//             children: _buildGridItems(),
//           ),
//         ),
//       );
//     }

//     // Display other pages
//     return _pages[_selectedIndex];
//   }

//   List<Widget> _buildGridItems() => [
//         _buildGridItem(
//           title: 'Record',
//           subtitle: 'and transcribe',
//           icon: Icons.mic,
//           color: _colorScheme['record']!,
//           page: const AudioText(),
//         ),
//         _buildGridItem(
//           title: 'Pick a File',
//           subtitle: 'Audio/Video File',
//           icon: Icons.file_copy,
//           color: _colorScheme['file']!,
//           page: const PickFilePage(),
//         ),
//         _buildGridItem(
//           title: 'From URL',
//           subtitle: 'From YouTube',
//           icon: Icons.link,
//           color: _colorScheme['url']!,
//           page: UrlInputPage(), // Updated to navigate to UrlInputPage
//         ),
//         _buildGridItem(
//           title: 'Share File',
//           subtitle: 'From WhatsApp',
//           icon: Icons.share,
//           color: _colorScheme['share']!,
//           page: const ShareFilesPage(),
//         ),
//       ];

//   Widget _buildGridItem({
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required Color color,
//     required Widget page,
//   }) =>
//       GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => page),
//           );
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(icon, size: 50, color: color),
//                 const SizedBox(height: 10),
//                 Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold, color: color),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   subtitle,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                       fontSize: 14, color: Color.fromARGB(255, 51, 124, 112)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:studie/pages/audio/audio_text.dart';
import 'package:studie/pages/audio/recordings.dart';
import 'package:studie/pages/authetication/Login_Page.dart';
import 'package:studie/pages/file%20picker/pick_file_page.dart.dart';
import 'package:studie/pages/home/UrlInputPage.dart';
import 'package:studie/pages/home/files_page.dart';
import 'package:studie/pages/home/share_file.dart';
import 'package:studie/pages/settings/settings_page.dart';
import '../../main.dart'; // Import the ThemeNotifier

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final Map<String, Color> _colorScheme = {
    'record': const Color(0xFF673AB6),
    'file': const Color(0xFF673AB6),
    'url': const Color(0xFF673AB6),
    'share': const Color(0xFF673AB6),
  };

  final List<Widget> _pages = [
    const AudioText(),
    const RecordsPage(),
    const FilesPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Studiequil",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeNotifier.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: themeNotifier.toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
        backgroundColor: _colorScheme['record'],
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() => BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Recordings'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Files'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedItemColor: _colorScheme['record'],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      );

  Widget _buildBody() {
    if (_selectedIndex == 0) {
      // Display GridView for the Home page
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.0, // Ensuring the grid items are square-shaped
            children: _buildGridItems(),
          ),
        ),
      );
    }

    // Display other pages
    return _pages[_selectedIndex];
  }

  List<Widget> _buildGridItems() => [
        _buildGridItem(
          title: 'Record',
          subtitle: 'and transcribe',
          icon: Icons.mic,
          color: _colorScheme['record']!,
          page: const AudioText(),
        ),
        _buildGridItem(
          title: 'Pick a File',
          subtitle: 'Audio/Video File',
          icon: Icons.file_copy,
          color: _colorScheme['file']!,
          page: const PickFilePage(),
        ),
        _buildGridItem(
          title: 'From URL',
          subtitle: 'From YouTube',
          icon: Icons.link,
          color: _colorScheme['url']!,
          page: UrlInputPage(),
        ),
        _buildGridItem(
          title: 'Share File',
          subtitle: 'From WhatsApp',
          icon: Icons.share,
          color: _colorScheme['share']!,
          page: const ShareFilesPage(),
        ),
      ];

  Widget _buildGridItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget page,
  }) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, size: 50, color: color),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: color),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 51, 124, 112)),
                ),
              ],
            ),
          ),
        ),
      );
}
