import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class UrlInputPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _UrlInputPageState createState() => _UrlInputPageState();
}

class _UrlInputPageState extends State<UrlInputPage> {
  final TextEditingController _urlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _processUrl() {
    if (_formKey.currentState?.validate() ?? false) {
      String audioUrl = _urlController.text.trim();
      // Add logic to send the URL for transcription
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Processing URL: $audioUrl')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio URL Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter the URL of the audio file you want to transcribe:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Audio URL',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an audio URL';
                  }
                  if (!Uri.parse(value).isAbsolute) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _processUrl,
                child: const Text('transcribe'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}
