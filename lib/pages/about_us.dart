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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            AboutSection(
              title: 'About StudieQUill',
              content:
                  'TranscribeApp is a state-of-the-art audio transcription platform designed to make converting audio to text easy and efficient. '
                  'Our mission is to provide users with high-quality transcription services powered by advanced AI technology.',
            ),
            SizedBox(height: 20),
            AboutSection(
              title: 'Contact Us',
              content: 'studiequill@gmail.com',
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  final String title;
  final String content;
  final bool isBold;

  const AboutSection({
    super.key,
    required this.title,
    required this.content,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}
