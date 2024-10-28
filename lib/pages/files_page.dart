import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  List<FileSystemEntity> _files = [];

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  void _loadFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    setState(() {
      _files = directory
          .listSync()
          .where((file) => file.path.endsWith('.txt'))
          .toList();
    });
  }

  void _deleteFile(String path) {
    File(path).deleteSync();
    _loadFiles();
  }

  void _editFile(BuildContext context, String path) async {
    final contents = await File(path).readAsString();
    final TextEditingController controller =
        TextEditingController(text: contents);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(path.split('/').last),
        content: TextField(
          controller: controller,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Edit Transcription',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final editedText = controller.text;
              await File(path).writeAsString(editedText);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Transcription updated')),
              );
              _loadFiles(); // Reload files to reflect changes
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transcribed texts'),
      ),
      body: ListView.builder(
        itemCount: _files.length,
        itemBuilder: (context, index) {
          final file = _files[index];
          return ListTile(
            title: Text(file.path.split('/').last),
            onTap: () => _editFile(context, file.path),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteFile(file.path),
            ),
          );
        },
      ),
    );
  }
}
