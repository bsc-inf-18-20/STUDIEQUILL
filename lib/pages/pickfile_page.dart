import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:studie/pages/home/file_picker_service.dart';

class PickFilePage extends StatelessWidget {
  PickFilePage({super.key});

  // Create an instance of the FilePickerService
  final FilePickerService _filePickerService = FilePickerService();

  Future<void> _pickAudioFile(BuildContext context) async {
    // Request permission to access external storage
    if (await _filePickerService.requestStoragePermission()) {
      PlatformFile? file = await _filePickerService.pickAudioFile();

      if (file != null) {
        // The user picked a file
        String? path = file.path;

        if (path != null) {
          // Handle the file further (e.g., transcribing)
          File audioFile = File(path);
          String transcription =
              await _filePickerService.transcribeAudioFile(audioFile);
          // Show the transcription result
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Transcription: $transcription')),
          );
        }
      } else {
        // The user canceled the file picker
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No file selected')),
        );
      }
    } else {
      // Permission was denied
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

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
              onPressed: () => _pickAudioFile(context),
              child: const Text('Pick Audio File'),
            ),
          ],
        ),
      ),
    );
  }
}
