import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  List<File> _recordings = [];
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _loadRecordings();
  }

  Future<void> _initializePlayer() async {
    await _player.openPlayer();
  }

  @override
  void dispose() {
    _player.closePlayer();
    super.dispose();
  }

  Future<void> _loadRecordings() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = await directory.list().toList();

      // Filter files to get only `.aac` files
      setState(() {
        _recordings = files
            .where((entity) => entity is File && entity.path.endsWith('.aac'))
            .map((entity) => entity as File)
            .toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading recordings: $e')),
      );
    }
  }

  Future<void> _playRecording(String filePath) async {
    if (_isPlaying) {
      await _player.stopPlayer();
      setState(() => _isPlaying = false);
    } else {
      await _player.startPlayer(
          fromURI: filePath,
          whenFinished: () {
            setState(() => _isPlaying = false);
          });
      setState(() => _isPlaying = true);
    }
  }

  Future<void> _deleteRecording(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        setState(() {
          _recordings.removeWhere((recording) => recording.path == filePath);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recording deleted successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting recording: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recordings')),
      body: _recordings.isEmpty
          ? const Center(child: Text('No recordings found'))
          : ListView.builder(
              itemCount: _recordings.length,
              itemBuilder: (context, index) {
                final file = _recordings[index];
                return ListTile(
                  title: Text(file.path.split('/').last),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                        onPressed: () => _playRecording(file.path),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteRecording(file.path),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
