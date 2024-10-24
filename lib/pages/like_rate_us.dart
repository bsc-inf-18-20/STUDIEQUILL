import 'package:flutter/material.dart';

class LikeRateUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Like or Rate Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Enjoying the app? Leave us a review!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic to open app store for rating
              },
              child: Text('Rate Us on App Store'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement social media sharing logic
              },
              child: Text('Share on Social Media'),
            ),
          ],
        ),
      ),
    );
  }
}
