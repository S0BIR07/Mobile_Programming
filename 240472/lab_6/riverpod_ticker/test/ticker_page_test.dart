import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:riverpod_ticker/models/tick.dart';
import 'package:riverpod_ticker/providers/ticker_providers.dart';
import 'package:riverpod_ticker/ticker_page.dart';

Widget harness(dynamic o) => ProviderScope(
      overrides: [o],
      child: const MaterialApp(home: TickerPage()),
    );

final sample = [
  Tick(symbol: 'BTC', price: 100, change: 1.5, at: DateTime(2026))
];

void main() {
  testWidgets('loading shows spinner', (tester) async {
    await tester.pumpWidget(harness(
      tickerProvider.overrideWith((ref) => const Stream<List<Tick>>.empty()),
    ));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('data shows rows', (tester) async {
    await tester.pumpWidget(harness(
      tickerProvider.overrideWith((ref) => Stream.value(sample)),
    ));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('BTC'), findsOneWidget);
    expect(find.textContaining('▲'), findsOneWidget);
  });

  testWidgets('error without data shows retry', (tester) async {
    await tester.pumpWidget(harness(
      tickerProvider.overrideWith((ref) => Stream<List<Tick>>.error('boom')),
    ));
    // Advance fake clock by 100ms to flush stream error microtasks
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Retry'), findsOneWidget);
    expect(find.byType(MaterialBanner), findsNothing);
  });

  testWidgets('error after data shows banner over rows', (tester) async {
    final controller = StreamController<List<Tick>>();
    addTearDown(controller.close);

    await tester.pumpWidget(harness(
      tickerProvider.overrideWith((ref) => controller.stream),
    ));

    // 1. Emit initial sample data
    controller.add(sample);
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('BTC'), findsOneWidget);
    expect(find.byType(MaterialBanner), findsNothing);

    // 2. Emit error while preserving previous data state in Riverpod
    controller.addError('Feed connection lost');
    await tester.pump(const Duration(milliseconds: 100));

    // Verify both MaterialBanner and previous data ('BTC') are rendered
    expect(find.byType(MaterialBanner), findsOneWidget);
    expect(find.text('BTC'), findsOneWidget);
    expect(
      find.textContaining('Feed error: Feed connection lost'),
      findsOneWidget,
    );
  });
}