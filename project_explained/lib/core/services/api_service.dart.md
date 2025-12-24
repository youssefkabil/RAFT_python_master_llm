# File: `lib/core/services/api_service.dart`

This file handles all communication with the backend AI server. It uses a streaming approach to receive the AI's response piece by piece, similar to ChatGPT.

### 1. Imports
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
```
**Explanation:**
- `dart:convert`: Used for encoding data to JSON (`jsonEncode`) and decoding the response stream (`utf8.decoder`).
- `package:http/http.dart`: A standard library for making HTTP requests. We use this to send the prompt to the server.

### 2. ApiService Class & Base URL
```dart
class ApiService {
  // Hardcoded based on user request
  final String _baseUrl = 'https://nonpredictable-smirkingly-marva.ngrok-free.dev';
  // ...
}
```
**Explanation:**
- `ApiService`: A class responsible for API logic.
- `_baseUrl`: The URL of your backend server (currently an ngrok tunnel). This is where requests are sent.

### 3. Generate Stream Function
```dart
Stream<String> generateStream(String prompt) async* {
  final client = http.Client();
  try {
    final request = http.Request('POST', Uri.parse('$_baseUrl/generate-stream'));
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode({'prompt': prompt});
    // ...
  }
  // ...
}
```
**Explanation:**
- `Stream<String>`: The function returns a "Stream" of strings, meaning it will yield multiple pieces of text over time instead of just one final result.
- `async*`: This keyword marks the function as a generator that can yield values asynchronously.
- `http.Client()`: Creates a new HTTP client connection.
- `http.Request`: We manually construct a POST request to the `/generate-stream` endpoint.
- `jsonEncode`: Converts the user's prompt into a JSON string `{"prompt": "..."}` to send to the server.

### 4. Sending Request & Handling Response
```dart
    final response = await client.send(request);

    // Using transform(utf8.decoder) directly on the stream.
    final stream = response.stream.transform(utf8.decoder);
    
    yield* stream;
```
**Explanation:**
- `client.send(request)`: Sends the request and waits for the initial connection.
- `response.stream`: We don't wait for the whole body. We access the incoming data stream directly.
- `transform(utf8.decoder)`: The raw data comes in bytes. This converts those bytes into readable text (Strings) on the fly.
- `yield* stream`: This forwards all the events from the response stream to the caller of `generateStream`.

### 5. Error Handling & Cleanup
```dart
  } catch (e) {
    throw Exception('API Error: $e');
  } finally {
    client.close();
  }
```
**Explanation:**
- `catch (e)`: If the network fails or server errors, we catch the exception and throw a cleaner error message.
- `finally { client.close(); }`: Ensure we close the HTTP connection when done to prevent memory leaks, whether the request succeeded or failed.
