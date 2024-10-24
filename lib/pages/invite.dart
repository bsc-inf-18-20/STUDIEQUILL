import 'package:flutter/material.dart';

class InvitePage extends StatelessWidget {
  const InvitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite Friends'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Invite your friends to TranscribeApp and earn free transcriptions!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.email),
              label: const Text('Invite via Email'),
              onPressed: () {
                // Implement email invitation logic
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.sms),
              label: const Text('Invite via SMS'),
              onPressed: () {
                // Implement SMS invitation logic
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.share),
              label: const Text('Share on Social Media'),
              onPressed: () {
                // Implement social media sharing logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
