import 'package:flutter/material.dart';

class InvitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite Friends'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Invite your friends to TranscribeApp and earn free transcriptions!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.email),
              label: Text('Invite via Email'),
              onPressed: () {
                // Implement email invitation logic
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.sms),
              label: Text('Invite via SMS'),
              onPressed: () {
                // Implement SMS invitation logic
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.share),
              label: Text('Share on Social Media'),
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
