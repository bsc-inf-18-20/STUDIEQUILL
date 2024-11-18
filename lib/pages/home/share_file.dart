import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareFilesPage extends StatefulWidget {
  const ShareFilesPage({super.key});

  @override
  _ShareFilesPageState createState() => _ShareFilesPageState();
}

class _ShareFilesPageState extends State<ShareFilesPage> {
  List<File> _transcribedFiles = [];

  @override
  void initState() {
    super.initState();
    _loadTranscribedFiles();
  }

  Future<void> _loadTranscribedFiles() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = await directory.list().toList();
      setState(() {
        _transcribedFiles = files
            .where((entity) => entity is File && entity.path.endsWith('.txt'))
            .map((entity) => entity as File)
            .toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading files: $e')),
      );
    }
  }

  Future<void> _shareFile(File file) async {
    try {
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Sharing a transcribed file via WhatsApp!',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Files'),
      ),
      body: _transcribedFiles.isEmpty
          ? const Center(child: Text('No transcribed files found'))
          : ListView.builder(
              itemCount: _transcribedFiles.length,
              itemBuilder: (context, index) {
                final file = _transcribedFiles[index];
                return ListTile(
                  title: Text(file.path.split('/').last),
                  trailing: IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () => _shareFile(file),
                  ),
                );
              },
            ),
    );
  }
}
