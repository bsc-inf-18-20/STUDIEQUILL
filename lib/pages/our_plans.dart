import 'package:flutter/material.dart';

class OurPlansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Plans'),
      ),
      body: const Center(
        child: Text(
          'Details about Our Plans',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
