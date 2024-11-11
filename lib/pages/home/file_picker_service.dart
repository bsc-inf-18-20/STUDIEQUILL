import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FilePickerService {
  // Request storage permission (necessary on Android)
  Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.status;

    if (status.isDenied) {
      // Request the permission
      status = await Permission.storage.request();
    }

    // Check if permission was permanently denied
    if (status.isPermanentlyDenied) {
      // Open app settings to allow the user to grant permission manually
      await openAppSettings();
      return false; // Permission was denied permanently
    }

    return status.isGranted; // Return true if granted
  }

  // Pick an audio file
  Future<PlatformFile?> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Use custom to define specific types
      allowedExtensions: ['mp3', 'wav', 'm4a'], // Allowed audio file extensions
    );

    if (result != null) {
      return result.files.first;
    }
    return null; // Return null if no file is selected
  }

  // Simulate audio transcription (this can be replaced with a real transcription service)
  Future<String> transcribeAudioFile(File audioFile) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
    return "This is a simulated transcription of the audio file."; // Simulated result
  }
}
