import 'package:flutter/material.dart';
import 'package:studie/pages/home/files_page.dart';
import 'package:studie/pages/home/filestorage_service.dart';
import 'dart:async';

import 'package:studie/pages/audio/trancription_service.dart';

class AudioText extends StatefulWidget {
  const AudioText({super.key});

  @override
  _AudioTextState createState() => _AudioTextState();
}

class _AudioTextState extends State<AudioText> {
  final TranscriptionService _transcriptionService = TranscriptionService();
  final FileStorageService _fileStorageService = FileStorageService();

  bool _isListening = false;
  String _text = 'Tap the button and start speaking';
  String _accumulatedText = '';
  Duration _elapsedTime = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _transcriptionService.initialize(
      onResult: _onSpeechResult,
      onError: _onSpeechError,
    );
  }

  void _onSpeechResult(String recognizedWords) {
    setState(() {
      _text = recognizedWords;
      _accumulatedText += ' $recognizedWords';
    });
  }

  void _onSpeechError(String errorMessage) {
    setState(() {
      _text = "Error: $errorMessage";
      _isListening = false;
      _stopTimer();
    });
  }

  void _listen() {
    if (!_isListening) {
      _startListening();
    } else {
      _stopListening();
    }
  }

  void _startListening() {
    setState(() {
      _isListening = true;
      _elapsedTime = Duration.zero;
    });
    _transcriptionService.startListening(_onSpeechResult);
    _startTimer();
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _transcriptionService.stopListening();
    _stopTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = Duration(seconds: _elapsedTime.inSeconds + 1);
        if (_elapsedTime.inSeconds >= 30) {
          _stopListening();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  Future<void> _saveText() async {
    await _fileStorageService.saveText(_accumulatedText);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transcribed text saved')),
    );

    setState(() {
      _text = 'Tap the button and start speaking';
      _accumulatedText = '';
      _elapsedTime = Duration.zero;
      _isListening = false;
    });
    _stopTimer();
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
                child: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              if (_isListening)
                Text(
                  'Recording Time: ${_elapsedTime.inMinutes}:${(_elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}',
                  style:
                      const TextStyle(fontSize: 20, color: Color(0xFFA3A3A3)),
                ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EFEF),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  _text,
                  style:
                      const TextStyle(fontSize: 24, color: Color(0xFF929191)),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveText,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF337C70),
                  foregroundColor: Colors.white,
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
