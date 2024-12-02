import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:studie/pages/file%20picker/file_picker_service.dart';
import 'package:test/test.dart';

class MockPermission extends Mock implements Permission {}

class MockFilePickerPlatform extends Mock implements FilePickerPlatform {}

class MockFile extends Mock implements File {}

void main() {
  group('FilePickerService', () {
    late FilePickerService filePickerService;
    late MockFile mockFile;

    setUp(() {
      filePickerService = FilePickerService();
      mockFile = MockFile();
    });

    test('requestStoragePermission should return true if permission is granted',
        () async {
      // Mocking the Permission handler
      when(Permission.storage.status)
          .thenAnswer((_) async => PermissionStatus.granted);

      final result = await filePickerService.requestStoragePermission();

      expect(result, isTrue);
    });

    test(
        'requestStoragePermission should return false if permission is permanently denied',
        () async {
      // Mocking the Permission handler
      when(Permission.storage.status)
          .thenAnswer((_) async => PermissionStatus.permanentlyDenied);

      final result = await filePickerService.requestStoragePermission();

      expect(result, isFalse);
    });

    test('pickAudioFile should return PlatformFile if a file is selected',
        () async {
      final mockResult = FilePickerResult([
        PlatformFile(name: 'test.mp3', size: 123, path: '/path/to/test.mp3')
      ]);

      // Mocking FilePicker behavior
      when(FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav', 'm4a'],
      )).thenAnswer((_) async => mockResult);

      final result = await filePickerService.pickAudioFile();

      expect(result, isNotNull);
      expect(result?.name, 'test.mp3');
    });

    test('pickAudioFile should return null if no file is selected', () async {
      // Mocking FilePicker behavior
      when(FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav', 'm4a'],
      )).thenAnswer((_) async => null);

      final result = await filePickerService.pickAudioFile();

      expect(result, isNull);
    });

    test('transcribeAudioFile should return simulated transcription', () async {
      when(mockFile.path).thenReturn('/path/to/test.mp3');

      final result = await filePickerService.transcribeAudioFile(mockFile);

      expect(result, 'This is a simulated transcription of the audio file.');
    });
  });
}
