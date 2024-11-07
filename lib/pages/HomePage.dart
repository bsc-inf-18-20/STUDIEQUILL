import 'package:flutter/material.dart';
import 'package:studie/pages/files_page.dart';
import 'package:studie/pages/notes_page.dart';
import 'package:studie/pages/pickfile_page.dart';
import 'package:studie/pages/workspace_page.dart';
import 'recordings.dart';
import 'settings_page.dart';
import 'package:studie/pages/audio_text.dart';

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

  List<NavigationItem> get _navigationItems => [
        const NavigationItem(
            icon: Icons.home, label: 'Home', page: AudioText()),
        const NavigationItem(
            icon: Icons.mic, label: 'Recordings', page: RecordsPage()),
        const NavigationItem(
            icon: Icons.folder, label: 'Files', page: FilesPage()),
        NavigationItem(
          icon: Icons.settings,
          label: 'Settings',
          page: SettingsPage(
            isDarkMode: widget.isDarkMode,
            onThemeChange: widget.onThemeChange,
          ),
        ),
      ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index != 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _navigationItems[index].page),
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
          "STUDIE APP",
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
          page: const PickFilePage(),
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

//  encapsulating navigation item properties
class NavigationItem {
  final IconData icon;
  final String label;
  final Widget page;

  const NavigationItem({
    required this.icon,
    required this.label,
    required this.page,
  });
}
