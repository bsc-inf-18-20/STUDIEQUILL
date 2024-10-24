import 'package:flutter/material.dart';

class LikeRateUsPage extends StatelessWidget {
  const LikeRateUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Like or Rate Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Enjoying the app? Leave us a review!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic to open app store for rating
              },
              child: const Text('Rate Us on App Store'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement social media sharing logic
              },
              child: const Text('Share on Social Media'),
            ),
          ],
        ),
      ),
    );
  }
}
