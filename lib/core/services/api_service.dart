
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Hardcoded based on user request
  final String _baseUrl = 'https://nonpredictable-smirkingly-marva.ngrok-free.dev';

  Stream<String> generateStream(String prompt) async* {
    final client = http.Client();
    try {
      final request = http.Request('POST', Uri.parse('$_baseUrl/generate-stream'));
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode({'prompt': prompt});

      final response = await client.send(request);

      // Using transform(utf8.decoder) directly on the stream.
      // This usually works better for http package than Dio for text/event-stream or chunked transfer.
      final stream = response.stream.transform(utf8.decoder);
      
      yield* stream;

    } catch (e) {
      throw Exception('API Error: $e');
    } finally {
      client.close();
    }
  }
}
