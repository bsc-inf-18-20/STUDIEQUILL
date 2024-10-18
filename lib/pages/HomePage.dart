import 'package:flutter/material.dart';
import 'package:studie/pages/files_page.dart';
import 'package:studie/pages/pickfile_page.dart';
import 'records_page.dart';
import 'notes_page.dart';
import 'workspace_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChange;

  const HomePage(
      {super.key, required this.isDarkMode, required this.onThemeChange});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
              isDarkMode: widget.isDarkMode,
              onThemeChange:
                  widget.onThemeChange, // Pass the callback to SettingsPage
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
          _buildRoundedBox('Record', 'and transcribe', Icons.mic,
              _colorScheme['record']!, context, const RecordsPage()),
          _buildRoundedBox('Pick a File', 'Audio/Video File', Icons.file_copy,
              _colorScheme['file']!, context, const PickFilePage()),
          _buildRoundedBox('From URL', 'From You Tube Or Drive', Icons.link,
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
            const SizedBox(height: 5), // Space between title and subtitle
            Text(
              subtitle, // Display the subtitle
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 51, 124, 112),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
