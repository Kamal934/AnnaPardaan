import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GoogleGeminiService {
  final String apiKey;
  final GenerativeModel model;

  GoogleGeminiService({required this.apiKey})
      : model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

  Future<String?> generateCaption(Uint8List imageBytes, String mimeType, String promptText) async {
    try {
      final prompt = TextPart(promptText);
      final imagePart = DataPart(mimeType, imageBytes);
      final response = await model.generateContent([
        Content.multi([prompt, imagePart])
      ]);
      return response.text;
    } catch (e) {
      if (kDebugMode) {
        print('Error generating caption: $e');
      }
      return null;
    }
  }
}
