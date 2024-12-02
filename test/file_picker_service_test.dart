import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:studie/pages/home/file_picker_service.dart';
import 'package:test/test.dart';

// Mock Classes
class MockPermission extends Mock implements Permission {}

class MockFilePickerPlatform extends Mock implements FilePickerPlatform {
  @override
  Future<FilePickerResult?> pickFiles({
    required FileType type,
    List<String>? allowedExtensions,
    bool allowMultiple = false,
    bool withData = false,
    bool allowCompression = true,
    String? dialogTitle,
    bool lockParentWindow = false,
  }) {
    return super.noSuchMethod(
      Invocation.method(
        #pickFiles,
        [],
        {
          #type: type,
          #allowedExtensions: allowedExtensions,
          #allowMultiple: allowMultiple,
          #withData: withData,
          #allowCompression: allowCompression,
          #dialogTitle: dialogTitle,
          #lockParentWindow: lockParentWindow,
        },
      ),
      returnValue: Future<FilePickerResult?>.value(null),
      returnValueForMissingStub: Future<FilePickerResult?>.value(null),
    );
  }
}

class MockFile extends Mock implements File {}

void main() {
  group('FilePickerService', () {
    late FilePickerService filePickerService;
    late MockFilePickerPlatform mockFilePickerPlatform;
    late MockFile mockFile;

    setUp(() {
      filePickerService = FilePickerService();
      mockFilePickerPlatform = MockFilePickerPlatform();
      FilePicker.platform =
          mockFilePickerPlatform; // Override platform for testing
      mockFile = MockFile();
    });

    test('requestStoragePermission returns true when permission is granted',
        () async {
      // Mock permission status as granted
      when(Permission.storage.status)
          .thenAnswer((_) async => PermissionStatus.granted);

      final result = await filePickerService.requestStoragePermission();

      expect(result, isTrue);
    });

    test(
        'requestStoragePermission returns false when permission is permanently denied',
        () async {
      // Mock permission status as permanently denied
      when(Permission.storage.status)
          .thenAnswer((_) async => PermissionStatus.permanentlyDenied);

      final result = await filePickerService.requestStoragePermission();

      expect(result, isFalse);
    });

    test('pickAudioFile returns a PlatformFile when a file is selected',
        () async {
      final mockResult = FilePickerResult([
        PlatformFile(name: 'test.mp3', size: 123, path: '/path/to/test.mp3'),
      ]);

      // Mock file picker behavior
      when(mockFilePickerPlatform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav', 'm4a'],
      )).thenAnswer((_) async => mockResult);

      final result = await filePickerService.pickAudioFile();

      expect(result, isNotNull);
      expect(result?.name, 'test.mp3');
    });

    test('pickAudioFile returns null when no file is selected', () async {
      // Mock file picker returning null
      when(mockFilePickerPlatform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav', 'm4a'],
      )).thenAnswer((_) async => null);

      final result = await filePickerService.pickAudioFile();

      expect(result, isNull);
    });

    test('transcribeAudioFile returns simulated transcription', () async {
      when(mockFile.path).thenReturn('/path/to/test.mp3');

      final result = await filePickerService.transcribeAudioFile(mockFile);

      expect(result, 'This is a simulated transcription of the audio file.');
    });
  });
}
