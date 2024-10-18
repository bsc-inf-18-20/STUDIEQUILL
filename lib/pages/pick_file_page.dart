import 'package:flutter/material.dart';

class PickFilePage extends StatelessWidget {
  const PickFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a File'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pick a file to upload and trascribe',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic for picking a file will go here
                // You can use a package like 'file_picker' or any other method
              },
              child: const Text('Pick File'),
            ),
          ],
        ),
      ),
    );
  }
}
