import 'dart:async';

void main() {
  int emissionCount = 0;
  late StreamSubscription<int> subscription;

  Stream<int> timerStream = Stream.periodic(
    const Duration(milliseconds: 500),
    (count) => count + 1,
  );
  
  print('Listening to stream...');

  subscription = timerStream.listen((value) {
    emissionCount++;
    print('Tick #$value emitted.');
    if (emissionCount == 5) {
      print('5 emissions reached. Cancelling subscription.');
      subscription.cancel();
    }
  });
}