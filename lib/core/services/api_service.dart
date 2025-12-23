
import 'dart:convert';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  // Hardcoded based on user request
  final String _baseUrl = 'https://nonpredictable-smirkingly-marva.ngrok-free.dev';

  Stream<String> generateStream(String prompt) async* {

    try {
      final response = await _dio.post(
        '$_baseUrl/generate-stream',
        data: {'prompt': prompt},
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'text/plain', // Expecting text chunks
          },
        ),
      );

      final stream = response.data.stream.cast<List<int>>();
      yield* stream.transform(utf8.decoder);
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }
}
