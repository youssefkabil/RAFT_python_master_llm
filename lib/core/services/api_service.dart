
import 'dart:convert';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  String? _baseUrl;

  void setBaseUrl(String url) {
    if (!url.startsWith('http')) {
      _baseUrl = 'https://$url'; 
    } else {
      _baseUrl = url;
    }
  }

  Stream<String> generateStream(String prompt) async* {
    if (_baseUrl == null || _baseUrl!.isEmpty) {
      throw Exception('Base URL not set. Please update in Settings.');
    }

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
