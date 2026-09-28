sealed class NetworkResult {}

class Success extends NetworkResult {
  final String data;
  Success(this.data);
}

class Failure extends NetworkResult {
  final int errorCode;
  Failure(this.errorCode);
}

class Loading extends NetworkResult {}

String handleResponse(NetworkResult result) {
  return switch (result) {
    Success(:var data) => 'Data received: $data',
    Failure(:var errorCode) => 'Error occurred with code: $errorCode',
    Loading() => 'Loading request...',
  };
}

void main() {
  NetworkResult res1 = Success('Payload OK');
  NetworkResult res2 = Failure(404);
  print(handleResponse(res1));
  print(handleResponse(res2));
}