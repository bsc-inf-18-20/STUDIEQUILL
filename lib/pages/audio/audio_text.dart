// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:async';

// class AudioText extends StatefulWidget {
//   const AudioText({Key? key}) : super(key: key);

//   @override
//   _AudioTextState createState() => _AudioTextState();
// }

// class _AudioTextState extends State<AudioText> {
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _transcription = '';
//   int _timerSeconds = 0; // Timer in seconds
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();

//     // Request permissions
//     requestPermissions();
//   }

//   // Function to request permissions
//   Future<void> requestPermissions() async {
//     PermissionStatus storageStatus = await Permission.storage.request();
//     PermissionStatus microphoneStatus = await Permission.microphone.request();

//     if (storageStatus.isGranted && microphoneStatus.isGranted) {
//       print('Permissions granted');
//     } else {
//       print('Permissions denied');
//     }
//   }

//   // Start/Stop listening
//   void _toggleListening() async {
//     if (_isListening) {
//       // Stop listening and capture the transcription
//       await _speech.stop();
//       _timer?.cancel(); // Stop the timer
//       setState(() {
//         _isListening = false;
//       });
//     } else {
//       // Clear previous transcription when starting a new recording
//       setState(() {
//         _transcription = '';
//         _timerSeconds = 0; // Reset the timer
//       });

//       // Start listening and transcribing
//       bool available = await _speech.initialize();
//       if (available) {
//         setState(() {
//           _isListening = true;
//         });

//         // Start a timer to track recording duration
//         _startTimer();

//         _speech.listen(
//           onResult: (result) {
//             setState(() {
//               _transcription = result.recognizedWords;
//             });
//           },
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Speech-to-text not available.')),
//         );
//       }
//     }
//   }

//   // Start a timer to track recording duration
//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         _timerSeconds++;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _speech.stop(); // Stop listening when the widget is disposed
//     _timer?.cancel(); // Cancel the timer when the widget is disposed
//   }

//   @override
//   Widget build(BuildContext context) {
//     String timerText =
//         _timerSeconds > 0 ? 'Recording Duration: ${_timerSeconds}s' : '';

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Audio to Text'),
//         backgroundColor: Colors.teal,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.teal.shade300, Colors.teal.shade700],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Timer Text
//                 Text(
//                   timerText,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 // Transcription area
//                 Container(
//                   padding: const EdgeInsets.all(20.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.8),
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 10,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     _transcription.isEmpty ? 'Speak Now' : _transcription,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.teal,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 // Recording Button
//                 ElevatedButton.icon(
//                   onPressed: _toggleListening,
//                   icon: Icon(
//                     _isListening ? Icons.stop : Icons.mic,
//                     size: 28,
//                     color: Colors.white,
//                   ),
//                   label: Text(
//                     _isListening ? 'Stop Recording' : 'Start Recording',
//                     style: const TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 5,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // Instructions Text
//                 Text(
//                   'Tap the button to start or stop recording.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white.withOpacity(0.8),
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AudioText extends StatefulWidget {
  const AudioText({Key? key}) : super(key: key);

  @override
  _AudioTextState createState() => _AudioTextState();
}

class _AudioTextState extends State<AudioText> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _transcription = '';
  int _timerSeconds = 0; // Timer in seconds
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    // Request permissions
    requestPermissions();
  }

  // Function to request permissions
  Future<void> requestPermissions() async {
    PermissionStatus storageStatus = await Permission.storage.request();
    PermissionStatus microphoneStatus = await Permission.microphone.request();

    if (storageStatus.isGranted && microphoneStatus.isGranted) {
      print('Permissions granted');
    } else {
      print('Permissions denied');
    }
  }

  // Start/Stop listening
  void _toggleListening() async {
    if (_isListening) {
      // Stop listening and capture the transcription
      await _speech.stop();
      _timer?.cancel(); // Stop the timer
      setState(() {
        _isListening = false;
      });

      // Save transcription to file
      await _saveTranscriptionToFile(_transcription);
    } else {
      // Clear previous transcription when starting a new recording
      setState(() {
        _transcription = '';
        _timerSeconds = 0; // Reset the timer
      });

      // Start listening and transcribing
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });

        // Start a timer to track recording duration
        _startTimer();

        _speech.listen(
          onResult: (result) {
            setState(() {
              _transcription = result.recognizedWords;
            });
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Speech-to-text not available.')),
        );
      }
    }
  }

  // Start a timer to track recording duration
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timerSeconds++;
      });
    });
  }

  // Save transcription to a text file
  Future<void> _saveTranscriptionToFile(String transcription) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/transcription_${DateTime.now().millisecondsSinceEpoch}.txt';
    final file = File(filePath);

    await file.writeAsString(transcription);
    print('Transcription saved at: $filePath');

    // Optionally, show a message or handle navigation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transcription saved successfully!')),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _speech.stop(); // Stop listening when the widget is disposed
    _timer?.cancel(); // Cancel the timer when the widget is disposed
  }

  @override
  Widget build(BuildContext context) {
    String timerText =
        _timerSeconds > 0 ? 'Recording Duration: ${_timerSeconds}s' : '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio to Text'),
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade300, Colors.teal.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Timer Text
                Text(
                  timerText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                // Transcription area
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    _transcription.isEmpty ? 'Speak Now' : _transcription,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                // Recording Button
                ElevatedButton.icon(
                  onPressed: _toggleListening,
                  icon: Icon(
                    _isListening ? Icons.stop : Icons.mic,
                    size: 28,
                    color: Colors.white,
                  ),
                  label: Text(
                    _isListening ? 'Stop Recording' : 'Start Recording',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                ),
                const SizedBox(height: 20),
                // Instructions Text
                Text(
                  'Tap the button to start or stop recording.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
