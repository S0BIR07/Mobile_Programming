import 'dart:async';

Stream<int> generateDataWithErrors() async* {
  yield 10;
  yield 20;
  throw Exception('Database connection lost!');
}

void main() {
  print('Subscribing to risky stream...');
  generateDataWithErrors()
      .map((val) => val * 2)
      .handleError((error) {
        print('Caught Stream Error: $error');
      })
      .listen(
        (data) => print('Stream Data Received: $data'),
        onDone: () => print('Stream processing finished.'),
      );
}