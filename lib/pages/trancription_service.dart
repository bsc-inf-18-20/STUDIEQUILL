import 'package:speech_to_text/speech_to_text.dart' as stt;

class TranscriptionService {
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isListening = false;

  bool get isListening => _isListening;

  Future<bool> initialize({
    required Function(String) onResult,
    required Function(String) onError,
  }) async {
    return await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' && _isListening) {
          _isListening = false;
        }
      },
      onError: (error) {
        onError(error.errorMsg);
      },
    );
  }

  void startListening(Function(String) onResult) {
    _isListening = true;
    _speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords);
      },
    );
  }

  void stopListening() {
    _speech.stop();
    _isListening = false;
  }
}
