import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            title: Text('How to upload an audio file'),
            subtitle: Text(
                'Step-by-step guide on uploading audio files for transcription.'),
          ),
          Divider(),
          ListTile(
            title: Text('Understanding transcription formats'),
            subtitle: Text(
                'Details on available transcription formats (e.g., plain text, JSON).'),
          ),
          Divider(),
          ListTile(
            title: Text('Contact Support'),
            subtitle: Text(
                'Email: support@transcribeapp.com\nPhone: +1 800 123 4567'),
          ),
        ],
      ),
    );
  }
}
