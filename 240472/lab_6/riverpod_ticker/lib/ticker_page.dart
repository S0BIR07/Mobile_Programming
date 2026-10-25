import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/ticker_providers.dart';
import 'widgets/tick_row.dart';

class TickerPage extends ConsumerWidget {
  const TickerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticks = ref.watch(tickerProvider);
    final failAfter = ref.watch(failAfterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Ticker'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(
              Icons.bug_report,
              color: failAfter != null ? Colors.red : null,
            ),
            tooltip: failAfter == null ? 'Simulate Error (Fail after 5)' : 'Clear Error Simulation',
            onPressed: () {
              final notifier = ref.read(failAfterProvider.notifier);
              if (failAfter == null) {
                notifier.setFailAfter(5);
              } else {
                notifier.setFailAfter(null);
                ref.invalidate(tickerProvider);
              }
            },
          ),
        ],
      ),
      body: switch (ticks) {
        // 1. Error with stale data: show rows dimmed, banner on top
        AsyncError(:final error, :final value?) => Column(
            children: [
              MaterialBanner(
                content: Text('Feed error: $error — showing last prices'),
                actions: [
                  TextButton(
                    onPressed: () => ref.invalidate(tickerProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
              Expanded(
                child: Opacity(
                  opacity: 0.5,
                  child: ListView(
                    children: [
                      for (final t in value) TickRow(t, key: ValueKey(t.symbol)),
                    ],
                  ),
                ),
              ),
            ],
          ),

        // 2. Error with nothing to show (cold start error)
        AsyncError(:final error) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Could not load ticker\n$error',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => ref.invalidate(tickerProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),

        // 3. Refresh/In-flight reload with previous data present: keep rows, show top progress bar
        AsyncValue(:final value?, isLoading: true) => Column(
            children: [
              const LinearProgressIndicator(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => ref.refresh(tickerProvider.future),
                  child: ListView(
                    children: [
                      for (final t in value) TickRow(t, key: ValueKey(t.symbol)),
                    ],
                  ),
                ),
              ),
            ],
          ),

        // 4. Normal data emission
        AsyncData(:final value) => RefreshIndicator(
            onRefresh: () => ref.refresh(tickerProvider.future),
            child: ListView(
              children: [
                for (final t in value) TickRow(t, key: ValueKey(t.symbol)),
              ],
            ),
          ),

        // 5. Initial cold loading state
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}