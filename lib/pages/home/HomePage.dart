import 'package:flutter/material.dart';
import 'package:studie/pages/home/files_page.dart';
import 'package:studie/pages/notes_page.dart';
import 'package:studie/pages/pickfile_page.dart';
import 'package:studie/pages/home/workspace_page.dart';
import '../audio/recordings.dart';
import '../settings/settings_page.dart';
import 'package:studie/pages/audio/audio_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(
        isDarkMode: isDarkMode,
        onThemeChange: toggleTheme,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChange;

  const HomePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChange,
  });

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

  // Lazy initialize pages only when accessed
  final List<Widget> _pages =
      List<Widget>.filled(4, Container(), growable: false);

  List<NavigationItem> get _navigationItems => [
        NavigationItem(
            icon: Icons.home,
            label: 'Home',
            pageBuilder: () => const AudioText()),
        NavigationItem(
            icon: Icons.mic,
            label: 'Recordings',
            pageBuilder: () => const RecordsPage()),
        NavigationItem(
            icon: Icons.folder,
            label: 'Files',
            pageBuilder: () => const FilesPage()),
        NavigationItem(
          icon: Icons.settings,
          label: 'Settings',
          pageBuilder: () => SettingsPage(
            isDarkMode: widget.isDarkMode,
            onThemeChange: widget.onThemeChange,
          ),
        ),
      ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Prevents unnecessary rebuilds
    setState(() => _selectedIndex = index);

    if (_pages[index] == Container()) {
      _pages[index] = _navigationItems[index].pageBuilder();
    }

    // Navigate only if the page is not the main page
    if (index != 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => _pages[index]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildHomePage(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text(
          "Studiequil",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: () => widget.onThemeChange(!widget.isDarkMode),
          ),
        ],
        backgroundColor: _colorScheme['record'],
      );

  BottomNavigationBar _buildBottomNavigationBar() => BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: _navigationItems
            .map((item) => BottomNavigationBarItem(
                icon: Icon(item.icon), label: item.label))
            .toList(),
        selectedItemColor: _colorScheme['record'],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      );

  Widget _buildHomePage() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: _buildGridItems(),
        ),
      );

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
          page: PickFilePage(),
        ),
        _buildGridItem(
          title: 'From URL',
          subtitle: 'From YouTube',
          icon: Icons.link,
          color: _colorScheme['url']!,
          page: const NotesPage(),
        ),
        _buildGridItem(
          title: 'Share File',
          subtitle: 'From WhatsApp',
          icon: Icons.share,
          color: _colorScheme['share']!,
          page: const WorkspacePage(),
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
              context, MaterialPageRoute(builder: (context) => page));
        },
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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

// Encapsulating navigation item properties
class NavigationItem {
  final IconData icon;
  final String label;
  final Widget Function() pageBuilder;

  const NavigationItem({
    required this.icon,
    required this.label,
    required this.pageBuilder,
  });
}
