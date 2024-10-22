// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';

// class PickFilePage extends StatelessWidget {
//   const PickFilePage({super.key});

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
//               onPressed: () async {
//                 FilePickerResult? result = await FilePicker.platform.pickFiles(
//                   type: FileType.custom, // defining file types
//                   allowedExtensions: [
//                     'mp3',
//                     'wav',
//                     'm4a'
//                   ], // Audio file extensions
//                 );

//                 if (result != null) {
//                   // User selected a file, get the file info
//                   PlatformFile file = result.files.first;

//                   // Show a SnackBar with the file name
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Picked file: ${file.name}')),
//                   );

//                   // You can add more logic here for uploading/transcribing the file
//                 } else {
//                   // User canceled the picker
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('No file selected')),
//                   );
//                 }
//               },
//               child: const Text('Pick Audio File'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
//         type: FileType.audio, // Use FileType.audio to select audio files
//       );

//       if (result != null) {
//         // The user picked a file
//         PlatformFile file = result.files.first;

//         // Show file information in a SnackBar
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Picked file: ${file.name}')),
//         );

//         // Handle the file further if needed (e.g., upload, process, etc.)
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
//       status = await Permission.storage.request();
//     }

//     return status.isGranted;
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
        type: FileType.audio, // Use FileType.audio to select audio files
      );

      if (result != null) {
        // The user picked a file
        PlatformFile file = result.files.first;

        // Show file information in a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Picked file: ${file.name}')),
        );

        // Handle the file further if needed (e.g., upload, process, etc.)
        String? path = file.path; // Get the file path

        if (path != null) {
          // Optionally open or use the file
          File audioFile = File(path);

          // Transcribe the audio file
          String transcription = await _transcribeAudio(audioFile);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Transcription: $transcription')),
          );

          // Optionally, you could upload the file as well
          await _uploadAudioFile(audioFile);
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

  // Request storage permission (necessary on Android)
  Future<bool> _requestStoragePermission() async {
    var status = await Permission.storage.status;

    if (status.isDenied) {
      status = await Permission.storage.request();
    }

    return status.isGranted;
  }

  // Placeholder for audio transcription logic
  Future<String> _transcribeAudio(File audioFile) async {
    // Implement your transcription logic here.
    // For example, you might use a service like Google Speech-to-Text
    // This is just a placeholder for now.
    return "Transcribed text from ${audioFile.path}"; // Replace with actual transcription result
  }

  // Placeholder for audio upload logic
  Future<void> _uploadAudioFile(File audioFile) async {
    // Implement your file upload logic here.
    // This could involve uploading to a server or cloud storage.
    print(
        'Uploading audio file: ${audioFile.path}'); // Replace with actual upload logic
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
