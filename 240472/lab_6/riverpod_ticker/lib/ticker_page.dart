import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/ticker_providers.dart';
import 'widgets/tick_row.dart';

class TickerPage extends ConsumerWidget {
  const TickerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticks = ref.watch(tickerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Ticker'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ticks.when(
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text('No symbols subscribed'));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final tick = list[index];
              return TickRow(tick, key: ValueKey(tick.symbol));
            },
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(
            'Error: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}