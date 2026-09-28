enum ApiResponse<T> {
  success<String>(payload: 'Data retrieved successfully', statusCode: 200),
  counter<int>(payload: 42, statusCode: 200),
  failure<Null>(payload: null, statusCode: 404);

  final T payload;
  final int statusCode;

  const ApiResponse({
    required this.payload,
    required this.statusCode,
  });

  bool get isSuccessful => statusCode >= 200 && statusCode < 300;
  
  static List<ApiResponse> getByStatusCode(int code) {
    return ApiResponse.values.where((res) => res.statusCode == code).toList();
  }
}

void main() {
  var response = ApiResponse.success;

  print('Response Payload: ${response.payload} (Type: ${response.payload.runtimeType})');
  print('Is Successful: ${response.isSuccessful}');

  print('\n--- Responses with Status Code 200 ---');
  var matches = ApiResponse.getByStatusCode(200);
  for (var match in matches) {
    print('Matched Enum: ${match.name} with Payload: ${match.payload}');
  }
}