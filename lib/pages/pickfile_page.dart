import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PickFilePage extends StatelessWidget {
  const PickFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick an Audio File'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pick an audio file to upload and transcribe',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom, // defining file types
                  allowedExtensions: [
                    'mp3',
                    'wav',
                    'm4a'
                  ], // Audio file extensions
                );

                if (result != null) {
                  // User selected a file, get the file info
                  PlatformFile file = result.files.first;

                  // Show a SnackBar with the file name
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Picked file: ${file.name}')),
                  );

                  // You can add more logic here for uploading/transcribing the file
                } else {
                  // User canceled the picker
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No file selected')),
                  );
                }
              },
              child: const Text('Pick Audio File'),
            ),
          ],
        ),
      ),
    );
  }
}
