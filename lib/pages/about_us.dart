import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'About StudieQUill',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'TranscribeApp is a state-of-the-art audio transcription platform designed to make converting audio to text easy and efficient. '
              'Our mission is to provide users with high-quality transcription services powered by advanced AI technology.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us: studiequill@gmail.com',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
