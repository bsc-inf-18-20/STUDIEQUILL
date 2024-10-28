// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';
// import 'package:permission_handler/permission_handler.dart'; // For requesting permissions

// class PickFilePage extends StatelessWidget {
//   const PickFilePage({super.key});

//   Future<void> _pickAudioFile(BuildContext context) async {
//     // Request permission to access external storage (Android-specific)
//     if (await _requestStoragePermission()) {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom, // Use custom to define specific types
//         allowedExtensions: [
//           'mp3',
//           'wav',
//           'm4a'
//         ], // Allowed audio file extensions
//       );

//       if (result != null) {
//         // The user picked a file
//         PlatformFile file = result.files.first;

//         // Show file information in a SnackBar
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Picked file: ${file.name}')),
//         );

//         // Handle the file further if needed (e.g., transcribing)
//         String? path = file.path; // Get the file path

//         if (path != null) {
//           // Optionally open or use the file
//           File audioFile = File(path);
//           // You can now pass this `audioFile` to other logic to handle it
//           // For example: Transcribing, playing, or uploading the file
//         }
//       } else {
//         // The user canceled the file picker
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('No file selected')),
//         );
//       }
//     } else {
//       // Permission was denied
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Storage permission denied')),
//       );
//     }
//   }

//   // Request storage permission (necessary on Android)
//   Future<bool> _requestStoragePermission() async {
//     var status = await Permission.storage.status;

//     if (status.isDenied) {
//       // Request the permission
//       status = await Permission.storage.request();
//     }

//     // Check if permission was permanently denied
//     if (status.isPermanentlyDenied) {
//       // Open app settings to allow the user to grant permission manually
//       await openAppSettings();
//       return false; // Permission was denied permanently
//     }

//     return status.isGranted; // Return true if granted
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pick an Audio File'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Pick an audio file to upload and transcribe',
//               style: TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _pickAudioFile(context),
//               child: const Text('Pick Audio File'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart'; // For requesting permissions

class PickFilePage extends StatelessWidget {
  const PickFilePage({super.key});

  Future<void> _pickAudioFile(BuildContext context) async {
    // Request permission to access external storage (Android-specific)
    if (await _requestStoragePermission()) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, // Use custom to define specific types
        allowedExtensions: [
          'mp3',
          'wav',
          'm4a',
        ], // Allowed audio file extensions
      );

      if (result != null) {
        // The user picked a file
        PlatformFile file = result.files.first;

        // Show file information in a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Picked file: ${file.name}')),
        );

        // Handle the file further (e.g., transcribing)
        String? path = file.path; // Get the file path

        if (path != null) {
          // Pass this `audioFile` to the transcribe method
          File audioFile = File(path);
          String transcription = await _transcribeAudioFile(audioFile);
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

  // Simulated audio transcription method
  Future<String> _transcribeAudioFile(File audioFile) async {
    // Here you would normally call your transcription service
    // For this example, we're simulating a delay and returning a dummy transcription
    await Future.delayed(Duration(seconds: 2)); // Simulating a delay
    return "This is a simulated transcription of the audio file."; // Simulated result
  }

  // Request storage permission (necessary on Android)
  Future<bool> _requestStoragePermission() async {
    var status = await Permission.storage.status;

    if (status.isDenied) {
      // Request the permission
      status = await Permission.storage.request();
    }

    // Check if permission was permanently denied
    if (status.isPermanentlyDenied) {
      // Open app settings to allow the user to grant permission manually
      await openAppSettings();
      return false; // Permission was denied permanently
    }

    return status.isGranted; // Return true if granted
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
