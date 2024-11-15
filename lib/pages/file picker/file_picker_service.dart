import 'dart:io';
import 'package:file_picker/file_picker.dart';

// Abstraction for file picking
abstract class FilePickerService {
  Future<File?> pickAudioFile();
}

// Concrete implementation of FilePickerService
class FilePickerServiceImpl implements FilePickerService {
  @override
  Future<File?> pickAudioFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav', 'm4a'], // Restrict to audio files
      );

      if (result != null) {
        return File(result.files.single.path!);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error picking file: $e');
    }
  }
}
