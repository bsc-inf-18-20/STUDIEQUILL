import 'package:flutter/material.dart';

class InvitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite Friends'),
      ),
      body: const Center(
        child: Text(
          'Invite your friends to join!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
