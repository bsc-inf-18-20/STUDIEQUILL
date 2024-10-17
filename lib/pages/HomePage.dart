// ignore: file_names
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Method to handle bottom nav item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2, // Two boxes per row
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildRoundedBox('Record,', Icons.mic, Colors.blue),
          _buildRoundedBox('Pick a File', Icons.file_copy, Colors.green),
          _buildRoundedBox('From URL', Icons.link, Colors.orange),
          _buildRoundedBox('Share File', Icons.share, Colors.red),
        ],
      ),
    );
  }

  // Method to build each rounded box
  Widget _buildRoundedBox(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle tap if needed
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2), // Light color background
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

  // List of pages for each navigation item
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildHomePage(), // Home page with four rounded boxes
      const Center(child: Text('Records')),
      const Center(child: Text('Files')),
      const Center(child: Text('Notes')),
      const Center(child: Text('Workspace')),
      const Center(child: Text('Settings')),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: _pages[_selectedIndex], // Display the selected page

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Handle taps
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
}
