/// A production-ready HTTP Client API service.
///
/// Handles network communication, response parsing, and error management.
///
/// ### Example Usage:
/// ```dart
/// final client = ApiClient(baseUrl: '[https://api.example.com](https://api.example.com)');
/// final data = await client.fetchData('/users');
/// print(data);
/// ```
class ApiClient {
  /// The base domain URL for API endpoints.
  final String baseUrl;

  /// Creates an [ApiClient] with a required [baseUrl].
  const ApiClient({required this.baseUrl});

  /// Fetches raw JSON data from a given [endpoint].
  ///
  /// Takes a target [endpoint] path (e.g., `/users/1`).
  /// Returns a [Future] resolving to a simulated JSON response map.
  ///
  /// Throws an [ArgumentError] if [endpoint] does not start with `/`.
  Future<Map<String, dynamic>> fetchData(String endpoint) async {
    if (!endpoint.startsWith('/')) {
      throw ArgumentError('Endpoint path must begin with a forward slash "/".');
    }

    // Simulating network response delay
    await Future.delayed(const Duration(milliseconds: 200));

    return {
      'status': 200,
      'url': '$baseUrl$endpoint',
      'data': {'id': 240472, 'status': 'active'},
    };
  }
}

void main() async {
  final api = ApiClient(baseUrl: 'https://api.course.edu');
  
  try {
    final response = await api.fetchData('/student');
    print('API Response: $response');
  } catch (e) {
    print('API Error: $e');
  }
}