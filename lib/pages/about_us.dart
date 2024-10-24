import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Center(
        child: Text(
          'Learn more about us here.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
