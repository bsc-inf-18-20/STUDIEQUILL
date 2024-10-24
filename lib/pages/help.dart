import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: const Center(
        child: Text(
          'Help and FAQs',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
