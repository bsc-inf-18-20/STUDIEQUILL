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
// import 'package:flutter/material.dart';
// import 'package:googleapis/drive/v3.dart' as drive;
// import 'package:googleapis_auth/googleapis_auth.dart';
// import 'package:http/http.dart' as http;

// class PickFilePage extends StatelessWidget {
//   const PickFilePage({super.key});

//   // Replace with your OAuth2 credentials
//   final String _clientId = "YOUR_CLIENT_ID";
//   final String _clientSecret = "YOUR_CLIENT_SECRET";

//   Future<void> _pickAudioFile(BuildContext context) async {
//     // Step 1: Authenticate with Google
//     var client = await _getAuthenticatedClient();
//     if (client == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Authentication failed')),
//       );
//       return;
//     }

//     // Step 2: Access Google Drive
//     final driveApi = drive.DriveApi(client);
//     try {
//       var fileList = await driveApi.files.list(
//         q: "mimeType='audio/mpeg'", // Adjust MIME type as necessary
//         $fields: "files(id,name)",
//       );

//       // Step 3: Show file picker (list files)
//       _showFilePicker(context, fileList.files);
//     } catch (e) {
//       print("Error accessing Drive: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to access Google Drive')),
//       );
//     } finally {
//       client.close(); // Close the client after use
//     }
//   }

//   // Function to authenticate with Google
//   Future<http.Client?> _getAuthenticatedClient() async {
//     var clientId = ClientId(_clientId, _clientSecret);
//     var scopes = [drive.DriveApi.driveScope]; // Adjust scopes as necessary

//     // Using the Google APIs Auth library for OAuth2
//     try {
//       var flow = await clientViaUserConsent(clientId, scopes, (url) {
//         print("Please go to the following URL: $url");
//       });
//       return flow;
//     } catch (e) {
//       print("Authentication error: $e");
//       return null;
//     }
//   }

//   void _showFilePicker(BuildContext context, List<drive.File>? files) {
//     if (files == null || files.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No audio files found')),
//       );
//       return;
//     }

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select an Audio File'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: files.map((file) {
//                 return ListTile(
//                   title: Text(file.name ?? 'No name'),
//                   onTap: () {
//                     // Handle file selection
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Selected file: ${file.name}')),
//                     );
//                     Navigator.of(context).pop();
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pick an Audio File from Google Drive'),
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
//               child: const Text('Upload Audio File from Google Drive'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
