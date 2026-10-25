import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tick.dart';
import '../services/tick_feed.dart';

class FailAfterNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void setFailAfter(int? value) => state = value;
}

final failAfterProvider = NotifierProvider<FailAfterNotifier, int?>(
  FailAfterNotifier.new,
);

final tickFeedProvider = Provider<TickFeed>((ref) {
  return TickFeed(failAfter: ref.watch(failAfterProvider));
});

final tickerProvider = StreamProvider.autoDispose<List<Tick>>((ref) {
  return ref.watch(tickFeedProvider).watch();
});