import 'package:cart_four_ways/setstate/cart_page_setstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('setState cart: tap Keyboard twice, apply SAVE10, assert total 88.20', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SetStateCartPage()),
    );

    // Tap Keyboard chip twice
    final keyboardChip = find.textContaining('Keyboard');
    await tester.tap(keyboardChip);
    await tester.pump();
    await tester.tap(keyboardChip);
    await tester.pump();

    // Enter SAVE10 coupon code
    final textField = find.byType(TextField);
    await tester.enterText(textField, 'SAVE10');
    await tester.pump();

    // Tap Apply button
    final applyButton = find.text('Apply');
    await tester.tap(applyButton);
    await tester.pump();

    // Assert total reads 88.20 (Keyboard 49 * 2 = 98 - 10% = 88.20)
    expect(find.text('\$88.20'), findsOneWidget);
  });
}