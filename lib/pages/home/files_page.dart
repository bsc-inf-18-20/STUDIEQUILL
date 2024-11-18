// // import 'package:flutter/material.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'dart:io';

// // class FilesPage extends StatefulWidget {
// //   const FilesPage({super.key});

// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _FilesPageState createState() => _FilesPageState();
// // }

// // class _FilesPageState extends State<FilesPage> {
// //   List<FileSystemEntity> _files = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadFiles();
// //   }

// //   void _loadFiles() async {
// //     final directory = await getApplicationDocumentsDirectory();
// //     setState(() {
// //       _files = directory
// //           .listSync()
// //           .where((file) => file.path.endsWith('.txt'))
// //           .toList();
// //     });
// //   }

// //   void _deleteFile(String path) {
// //     File(path).deleteSync();
// //     _loadFiles();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Transcribed Texts'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: _files.length,
// //         itemBuilder: (context, index) {
// //           final file = _files[index];
// //           return ListTile(
// //             title: Text(file.path.split('/').last),
// //             onTap: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => FileEditorPage(filePath: file.path),
// //                 ),
// //               );
// //             },
// //             trailing: IconButton(
// //               icon: const Icon(Icons.delete),
// //               onPressed: () => _deleteFile(file.path),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // class FileEditorPage extends StatefulWidget {
// //   final String filePath;

// //   const FileEditorPage({required this.filePath, super.key});

// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _FileEditorPageState createState() => _FileEditorPageState();
// // }

// // class _FileEditorPageState extends State<FileEditorPage> {
// //   late TextEditingController _controller;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadFileContent();
// //   }

// //   void _loadFileContent() async {
// //     final content = await File(widget.filePath).readAsString();
// //     setState(() {
// //       _controller = TextEditingController(text: content);
// //     });
// //   }

// //   void _saveFile() async {
// //     final editedText = _controller.text;
// //     await File(widget.filePath).writeAsString(editedText);
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(content: Text('Transcription updated')),
// //     );
// //     Navigator.pop(context);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.filePath.split('/').last),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.save),
// //             onPressed: _saveFile,
// //           ),
// //         ],
// //       ),
// //       // ignore: unnecessary_null_comparison
// //       body: _controller == null
// //           ? const Center(child: CircularProgressIndicator())
// //           : Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: TextField(
// //                 controller: _controller,
// //                 maxLines: null,
// //                 decoration: const InputDecoration(
// //                   border: OutlineInputBorder(),
// //                   labelText: 'Edit Transcription',
// //                 ),
// //               ),
// //             ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:path/path.dart' as p;

// class FilesPage extends StatefulWidget {
//   const FilesPage({super.key});

//   @override
//   _FilesPageState createState() => _FilesPageState();
// }

// class _FilesPageState extends State<FilesPage> {
//   List<FileSystemEntity> _files = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadFiles();
//   }

//   void _loadFiles() async {
//     final directory = await getApplicationDocumentsDirectory();
//     print('Listing files in: ${directory.path}');

//     final files = await directory.list().toList();
//     for (var file in files) {
//       print('Found file: ${file.path}');
//     }

//     setState(() {
//       _files = files.where((file) => file.path.endsWith('.txt')).toList();
//     });
//   }

//   void _deleteFile(String path) {
//     File(path).deleteSync();
//     _loadFiles();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Transcribed Texts'),
//       ),
//       body: _files.isEmpty
//           ? const Center(child: Text('No transcribed texts found'))
//           : ListView.builder(
//               itemCount: _files.length,
//               itemBuilder: (context, index) {
//                 final file = _files[index];
//                 return ListTile(
//                   title: Text(p.basename(file.path)),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             FileEditorPage(filePath: file.path),
//                       ),
//                     );
//                   },
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: () => _deleteFile(file.path),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// class FileEditorPage extends StatefulWidget {
//   final String filePath;

//   const FileEditorPage({required this.filePath, super.key});

//   @override
//   _FileEditorPageState createState() => _FileEditorPageState();
// }

// class _FileEditorPageState extends State<FileEditorPage> {
//   late TextEditingController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _loadFileContent();
//   }

//   void _loadFileContent() async {
//     try {
//       final content = await File(widget.filePath).readAsString();
//       setState(() {
//         _controller = TextEditingController(text: content);
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load file: $e')),
//       );
//     }
//   }

//   void _saveFile() async {
//     final editedText = _controller.text;
//     await File(widget.filePath).writeAsString(editedText);
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Transcription updated')),
//     );
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(p.basename(widget.filePath)),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: _saveFile,
//           ),
//         ],
//       ),
//       // ignore: unnecessary_null_comparison
//       body: _controller == null
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 controller: _controller,
//                 maxLines: null,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Edit Transcription',
//                 ),
//               ),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

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
    print('Listing files in: ${directory.path}');

    final files = await directory.list().toList();
    for (var file in files) {
      print('Found file: ${file.path}');
    }

    setState(() {
      _files = files.where((file) => file.path.endsWith('.txt')).toList();
    });
  }

  void _deleteFile(String path) {
    File(path).deleteSync();
    _loadFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transcribed Texts'),
      ),
      body: _files.isEmpty
          ? const Center(child: Text('No transcribed texts found'))
          : ListView.builder(
              itemCount: _files.length,
              itemBuilder: (context, index) {
                final file = _files[index];
                return ListTile(
                  title: Text(p.basename(file.path)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FileEditorPage(filePath: file.path),
                      ),
                    );
                  },
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

class FileEditorPage extends StatefulWidget {
  final String filePath;

  const FileEditorPage({required this.filePath, super.key});

  @override
  _FileEditorPageState createState() => _FileEditorPageState();
}

class _FileEditorPageState extends State<FileEditorPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _loadFileContent();
  }

  void _loadFileContent() async {
    try {
      final content = await File(widget.filePath).readAsString();
      _controller = TextEditingController(text: content);
      setState(() {});
    } catch (e) {
      _controller = TextEditingController(text: 'Error loading file.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit File'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Edit transcription...',
          ),
        ),
      ),
    );
  }
}
