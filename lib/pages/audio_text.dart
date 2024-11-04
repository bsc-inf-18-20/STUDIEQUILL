import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'files_page.dart'; // Import the FilesPage

class AudioText extends StatefulWidget {
  const AudioText({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
            _isListening = false; // updating listening status on error
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
        if (_elapsedTime.inSeconds >= 0.5 * 60) {
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
                child: Icon(_isListening ? Icons.mic : Icons.mic_none,
                    color: Colors.white), // changing mic button color
              ),
              const SizedBox(height: 16.0),
              if (_isListening)
                Text(
                  'Recording Time: ${_elapsedTime.inMinutes}:${(_elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFFA3A3A3)), // changing text color
                ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(
                      0xFFF0EFEF), // Changing text field background color
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  _text,
                  style: const TextStyle(
                      fontSize: 24,
                      color: Color(0xFF929191)), // Changing text color
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveText,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFF337C70), // changing save button background color
                  foregroundColor:
                      Colors.white, // changing save button text color
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
