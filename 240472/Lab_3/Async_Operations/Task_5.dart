void main() async {
  Stream<int> rawNumbers = Stream.fromIterable([1, 2, 2, 3, 4, 4, 4, 5, 6, 6, 7]);
  print('Processing stream transformations...');
  Stream<String> transformedStream = rawNumbers
      .where((number) => number.isEven)
      .distinct()
      .map((evenNumber) => 'EVEN: $evenNumber');

  await for (var item in transformedStream) {
    print('Received: $item');
  }
}