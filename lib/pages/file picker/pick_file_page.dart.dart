import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PickFilePage extends StatefulWidget {
  const PickFilePage({super.key});

  @override
  State<PickFilePage> createState() => _PickFilePageState();
}

class _PickFilePageState extends State<PickFilePage> {
  File? _selectedAudioFile;

  // Method to pick an audio file
  Future<void> _pickAudioFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav', 'm4a'], // Restrict to audio files
      );

      if (result != null) {
        // File selected
        setState(() {
          _selectedAudioFile = File(result.files.single.path!);
        });
      } else {
        // User canceled the picker
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No file selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  // Method to transcribe the selected file
  Future<void> _transcribeFile() async {
    if (_selectedAudioFile != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transcribing file...')),
      );
      // Here you would call your transcription logic/API.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected for transcription')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio File Picker'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: _selectedAudioFile == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.music_note,
                      size: 80,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Select an audio file to get started',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _pickAudioFile,
                      icon: const Icon(Icons.file_upload),
                      label: const Text('Pick Audio File'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 80,
                      color: Color(0xFF673AB6),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'File Selected Successfully',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF673AB6),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Text(
                        _selectedAudioFile!.path,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _transcribeFile,
                      icon: const Icon(Icons.translate),
                      label: const Text(
                        'Transcribe the File',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF673AB6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:studie/pages/audio/trancription_service.dart';
// // import 'package:studie/pages/audio/transcription_service.dart';
// import 'dart:io';
// import 'package:studie/pages/file%20picker/file_picker_service.dart';

// class PickFilePage extends StatefulWidget {
//   final FilePickerService filePickerService;
//   final TranscriptionService transcriptionService;

//   // Dependency Injection
//   const PickFilePage({
//     super.key,
//     required this.filePickerService,
//     required this.transcriptionService,
//   });

//   @override
//   State<PickFilePage> createState() => _PickFilePageState();
// }

// class _PickFilePageState extends State<PickFilePage> {
//   File? _selectedAudioFile;

//   // Pick an audio file using the injected file picker service
//   Future<void> _pickAudioFile() async {
//     try {
//       File? file = await widget.filePickerService.pickAudioFile();
//       if (file != null) {
//         setState(() {
//           _selectedAudioFile = file;
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('No file selected')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error picking file: $e')),
//       );
//     }
//   }

//   // Transcribe the selected file using the injected transcription service
//   Future<void> _transcribeFile() async {
//     if (_selectedAudioFile != null) {
//       try {
//         // await widget.transcriptionService.transcribeFile(_selectedAudioFile!);
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   const SnackBar(content: Text('Transcription in progress...')),
//         // );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error transcribing file: $e')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No file selected for transcription')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Audio File Picker'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Center(
//           child: _selectedAudioFile == null
//               ? Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.music_note,
//                       size: 80,
//                       color: Colors.blueAccent,
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'Select an audio file to get started',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 18, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton.icon(
//                       onPressed: _pickAudioFile,
//                       icon: const Icon(Icons.file_upload),
//                       label: const Text('Pick Audio File'),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 12),
//                       ),
//                     ),
//                   ],
//                 )
//               : Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.check_circle_outline,
//                       size: 80,
//                       color: Color(0xFF673AB6),
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'File Selected Successfully',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF673AB6),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Container(
//                       padding: const EdgeInsets.all(10.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.grey[200],
//                       ),
//                       child: Text(
//                         _selectedAudioFile!.path,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.black54,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton.icon(
//                       onPressed: _transcribeFile,
//                       icon: const Icon(Icons.translate),
//                       label: const Text(
//                         'Transcribe the File',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF673AB6),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 12),
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
