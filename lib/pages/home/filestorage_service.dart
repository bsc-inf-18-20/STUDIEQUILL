// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class FileStorageService {
//   Future<void> saveText(String text) async {
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File(
//         '${directory.path}/transcription_${DateTime.now().millisecondsSinceEpoch}.txt');
//     await file.writeAsString(text);
//   }
// }
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileStorageService {
  Future<void> saveText(String text) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
        '${directory.path}/transcription_${DateTime.now().millisecondsSinceEpoch}.txt');
    await file.writeAsString(text);
    print('Saved transcription to: ${file.path}');
  }
}
