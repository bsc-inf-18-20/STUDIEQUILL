// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'dart:async';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'files_page.dart'; // Import the FilesPage

// class AudioText extends StatefulWidget {
//   const AudioText({super.key});

//   @override
//   _AudioTextState createState() => _AudioTextState();
// }

// class _AudioTextState extends State<AudioText> {
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _text = 'Tap the button and start speaking';
//   String _accumulatedText = '';
//   Duration _elapsedTime = Duration.zero;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (status) {
//           print('Status: $status');
//           if (status == 'done' && _isListening) {
//             _restartListening();
//           }
//         },
//         onError: (error) {
//           print('Error: $error');
//           setState(() {
//             _isListening = false; // Update listening status on error
//             _text = "Error: ${error.errorMsg}";
//             _stopTimer();
//           });
//         },
//       );
//       if (available) {
//         setState(() {
//           _isListening = true;
//           _elapsedTime = Duration.zero;
//           _startTimer();
//         });
//         _speech.listen(
//           onResult: (result) => setState(() {
//             _text = result.recognizedWords;
//             _accumulatedText += ' ' + result.recognizedWords;
//           }),
//         );
//       } else {
//         setState(() {
//           _isListening = false;
//           _text = "Speech recognition not available";
//           _stopTimer();
//         });
//         _speech.stop();
//       }
//     } else {
//       setState(() {
//         _isListening = false;
//         _stopTimer();
//       });
//       _speech.stop();
//     }
//   }

//   void _restartListening() {
//     _speech.stop();
//     Future.delayed(const Duration(milliseconds: 500), () {
//       _speech.listen(
//         onResult: (result) => setState(() {
//           _text = result.recognizedWords;
//           _accumulatedText += ' ' + result.recognizedWords;
//         }),
//       );
//     });
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         _elapsedTime = Duration(seconds: _elapsedTime.inSeconds + 1);
//         if (_elapsedTime.inSeconds >= 5 * 60) {
//           // 5 minutes
//           _stopRecording();
//         }
//       });
//     });
//   }

//   void _stopTimer() {
//     _timer?.cancel();
//   }

//   void _stopRecording() {
//     if (_isListening) {
//       setState(() {
//         _isListening = false;
//         _speech.stop();
//         _stopTimer();
//       });
//     }
//   }

//   void _saveText() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File(
//         '${directory.path}/transcription_${DateTime.now().millisecondsSinceEpoch}.txt');
//     await file.writeAsString(_accumulatedText);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Transcribed text saved')),
//     );

//     // Reset for new recording
//     setState(() {
//       _text = 'Tap the button and start speaking'; // Reset the text
//       _accumulatedText = ''; // Reset accumulated text
//       _isListening = false; // Stop listening state
//       _elapsedTime = Duration.zero; // Reset elapsed time
//       _stopTimer(); // Stop any active timers
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Audio to Text'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.folder),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const FilesPage()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               FloatingActionButton(
//                 onPressed: _listen,
//                 child: Icon(_isListening ? Icons.mic : Icons.mic_none),
//                 backgroundColor: Color.fromARGB(
//                     255, 51, 124, 112), // Change mic button color
//               ),
//               const SizedBox(height: 16.0),
//               if (_isListening)
//                 Text(
//                   'Recording Time: ${_elapsedTime.inMinutes}:${(_elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}',
//                   style: const TextStyle(
//                       fontSize: 20,
//                       color: Color.fromARGB(
//                           255, 163, 163, 163)), // Change text color
//                 ),
//               const SizedBox(height: 16.0),
//               Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(
//                       255, 240, 239, 239), // Change text field background color
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Text(
//                   _text,
//                   style: const TextStyle(
//                       fontSize: 24,
//                       color: Color.fromARGB(
//                           255, 146, 145, 145)), // Change text color
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _saveText,
//                 child: const Text('Save'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromARGB(
//                       255, 51, 124, 112), // Change save button background color
//                   foregroundColor:
//                       Colors.white, // Change save button text color
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'files_page.dart'; // Import the FilesPage

class AudioText extends StatefulWidget {
  const AudioText({super.key});

  @override
  _AudioTextState createState() => _AudioTextState();
}

class _AudioTextState extends State<AudioText> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Tap the button and start speaking';
  String _accumulatedText = '';
  Duration _elapsedTime = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('Status: $status');
          if (status == 'done' && _isListening) {
            _restartListening();
          }
        },
        onError: (error) {
          print('Error: $error');
          setState(() {
            _isListening = false; // Update listening status on error
            _text = "Error: ${error.errorMsg}";
            _stopTimer();
          });
        },
      );
      if (available) {
        setState(() {
          _isListening = true;
          _elapsedTime = Duration.zero;
          _startTimer();
        });
        _speech.listen(
          onResult: (result) => setState(() {
            _text = result.recognizedWords;
            _accumulatedText += ' ${result.recognizedWords}';
          }),
        );
      } else {
        setState(() {
          _isListening = false;
          _text = "Speech recognition not available";
          _stopTimer();
        });
        _speech.stop();
      }
    } else {
      setState(() {
        _isListening = false;
        _stopTimer();
      });
      _speech.stop();
    }
  }

  void _restartListening() {
    _speech.stop();
    Future.delayed(const Duration(milliseconds: 500), () {
      _speech.listen(
        onResult: (result) => setState(() {
          _text = result.recognizedWords;
          _accumulatedText += ' ${result.recognizedWords}';
        }),
      );
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = Duration(seconds: _elapsedTime.inSeconds + 1);
        if (_elapsedTime.inSeconds >= 5 * 60) {
          // 5 minutes
          _stopRecording();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _stopRecording() {
    if (_isListening) {
      setState(() {
        _isListening = false;
        _speech.stop();
        _stopTimer();
      });
    }
  }

  void _saveText() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
        '${directory.path}/transcription_${DateTime.now().millisecondsSinceEpoch}.txt');
    await file.writeAsString(_accumulatedText);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transcribed text saved')),
    );

    // Reset for new recording
    setState(() {
      _text = 'Tap the button and start speaking'; // Reset the text
      _accumulatedText = ''; // Reset accumulated text
      _isListening = false; // Stop listening state
      _elapsedTime = Duration.zero; // Reset elapsed time
      _stopTimer(); // Stop any active timers
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio to Text'),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FilesPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: _listen,
                backgroundColor: const Color(0xFF337C70),
                child: Icon(_isListening
                    ? Icons.mic
                    : Icons.mic_none), // Change mic button color
              ),
              const SizedBox(height: 16.0),
              if (_isListening)
                Text(
                  'Recording Time: ${_elapsedTime.inMinutes}:${(_elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFFA3A3A3)), // Change text color
                ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(
                      0xFFF0EFEF), // Change text field background color
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  _text,
                  style: const TextStyle(
                      fontSize: 24,
                      color: Color(0xFF929191)), // Change text color
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveText,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFF337C70), // Change save button background color
                  foregroundColor:
                      Colors.white, // Change save button text color
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'dart:async';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_sound/flutter_sound.dart';
// import 'files_page.dart'; // Import the FilesPage

// class AudioText extends StatefulWidget {
//   const AudioText({super.key});

//   @override
//   _AudioTextState createState() => _AudioTextState();
// }

// class _AudioTextState extends State<AudioText> {
//   late stt.SpeechToText _speech;
//   late FlutterSoundRecorder _audioRecorder;
//   bool _isListening = false;
//   bool _isRecording = false;
//   String _text = 'Tap the button and start speaking';
//   Duration _elapsedTime = Duration.zero;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//     _audioRecorder = FlutterSoundRecorder();
//     _initializeRecorder();
//   }

//   Future<void> _initializeRecorder() async {
//     // No need to open an audio session in the latest versions
//     await _audioRecorder.openRecorder();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (status) => print('Status: $status'),
//         onError: (error) {
//           print('Error: $error');
//           setState(() {
//             _isListening = false; // Update listening status on error
//             _text = "Error: ${error.errorMsg}";
//             _stopTimer();
//           });
//         },
//       );
//       if (available) {
//         setState(() {
//           _isListening = true;
//           _elapsedTime = Duration.zero;
//           _startTimer();
//         });
//         _speech.listen(
//           onResult: (result) => setState(() {
//             _text = result.recognizedWords;
//           }),
//         );
//       } else {
//         setState(() {
//           _isListening = false;
//           _text = "Speech recognition not available";
//           _stopTimer();
//         });
//         _speech.stop();
//       }
//     } else {
//       setState(() {
//         _isListening = false;
//         _stopTimer();
//       });
//       _speech.stop();
//     }
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         _elapsedTime = Duration(seconds: _elapsedTime.inSeconds + 1);
//         if (_elapsedTime.inSeconds >= 60) {
//           _stopRecording();
//         }
//       });
//     });
//   }

//   void _stopTimer() {
//     _timer?.cancel();
//   }

//   void _stopRecording() async {
//     if (_isRecording) {
//       await _audioRecorder.stopRecorder();
//       setState(() {
//         _isRecording = false;
//         _stopTimer();
//       });
//     }
//   }

//   void _startRecording() async {
//     final directory = await getApplicationDocumentsDirectory();
//     String path = '${directory.path}/records.dat';
//     await _audioRecorder.startRecorder(
//       toFile: path,
//       codec: Codec.pcm16WAV,
//     );
//     setState(() {
//       _isRecording = true;
//       _text = "Recording...";
//     });
//   }

//   void _saveText() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File(
//         '${directory.path}/transcription_${DateTime.now().millisecondsSinceEpoch}.txt');
//     await file.writeAsString(_text);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Transcribed text saved')),
//     );

//     // Reset for new recording
//     setState(() {
//       _text = 'Tap the button and start speaking'; // Reset the text
//       _isListening = false; // Stop listening state
//       _elapsedTime = Duration.zero; // Reset elapsed time
//       _stopTimer(); // Stop any active timers
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _audioRecorder.closeRecorder(); // Close the recorder when disposing
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Audio to Text'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.folder),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const FilesPage()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   FloatingActionButton(
//                     onPressed: _startRecording,
//                     child: const Icon(Icons.mic),
//                     backgroundColor: Color.fromARGB(255, 51, 124, 112),
//                   ),
//                   const SizedBox(width: 16.0),
//                   FloatingActionButton(
//                     onPressed: _listen,
//                     child: Icon(_isListening ? Icons.mic : Icons.mic_none),
//                     backgroundColor: Color.fromARGB(255, 51, 124, 112),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16.0),
//               if (_isListening)
//                 Text(
//                   'Recording Time: ${_elapsedTime.inMinutes}:${(_elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}',
//                   style: const TextStyle(
//                       fontSize: 20, color: Color.fromARGB(255, 163, 163, 163)),
//                 ),
//               const SizedBox(height: 16.0),
//               Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 240, 239, 239),
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Text(
//                   _text,
//                   style: const TextStyle(
//                       fontSize: 24, color: Color.fromARGB(255, 146, 145, 145)),
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _saveText,
//                 child: const Text('Save'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromARGB(255, 51, 124, 112),
//                   foregroundColor: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
