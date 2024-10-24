import 'package:flutter/material.dart';

class OurPlansPage extends StatelessWidget {
  const OurPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Plans'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('Free Plan'),
            subtitle: const Text(
                '• 5 transcriptions per month\n• Basic transcription features'),
            trailing: ElevatedButton(
              onPressed: () {
                // Implement plan selection logic
              },
              child: const Text('Select'),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Premium Plan'),
            subtitle: const Text(
                '• Unlimited transcriptions\n• Fast processing\n• Advanced punctuation'),
            trailing: ElevatedButton(
              onPressed: () {
                // Implement plan selection logic
              },
              child: const Text('Select'),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Enterprise Plan'),
            subtitle: const Text(
                '• Custom pricing\n• API integration\n• 24/7 support'),
            trailing: ElevatedButton(
              onPressed: () {
                // Implement plan selection logic
              },
              child: const Text('Contact Us'),
            ),
          ),
        ],
      ),
    );
  }
}
