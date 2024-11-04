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
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Define a map of colors for easy customization
  final Map<String, Color> _colorScheme = {
    'record': const Color(0xFF673AB6),
    'file': const Color(0xFF673AB6),
    'url': const Color(0xFF673AB6),
    'share': const Color(0xFF673AB6),
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
          MaterialPageRoute(
            builder: (context) => SettingsPage(
              isDarkMode: widget.isDarkMode,
              onThemeChange: widget.onThemeChange,
            ),
          ),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            onPressed: () {
              widget.onThemeChange(!widget.isDarkMode);
            },
          ),
        ],
        elevation: 0,
        backgroundColor: _colorScheme['record'],
      ),
      body: _buildHomePage(context),

      // BottomNavigationBar without UserProfile widget
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Recordings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Files',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: _colorScheme['record'],
        unselectedItemColor: Colors.grey,
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
          _buildRoundedBox('Record', 'and transcribe', Icons.mic,
              _colorScheme['record']!, context, const AudioText()),
          _buildRoundedBox('Pick a File', 'Audio/Video File', Icons.file_copy,
              _colorScheme['file']!, context, const PickFilePage()),
          _buildRoundedBox('From URL', 'From YouTube', Icons.link,
              _colorScheme['url']!, context, const NotesPage()),
          _buildRoundedBox('Share File', 'From WhatsApp', Icons.share,
              _colorScheme['share']!, context, const WorkspacePage()),
        ],
      ),
    );
  }

  Widget _buildRoundedBox(String title, String subtitle, IconData icon,
      Color color, BuildContext context, Widget page) {
    return GestureDetector(
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 51, 124, 112),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
