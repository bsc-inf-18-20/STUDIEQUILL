import 'package:flutter/material.dart';

class LikeRateUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Like or Rate Us'),
      ),
      body: const Center(
        child: Text(
          'Please like or rate us!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
