import 'package:cart_four_ways/models/cart.dart';
import 'package:cart_four_ways/riverpod/cart_notifier.dart';
import 'package:cart_four_ways/services/checkout_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class FailingCheckoutApi implements CheckoutApi {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #submit) {
      return Future<dynamic>.error(const CheckoutException('Card declined'));
    }
    return super.noSuchMethod(invocation);
  }
}

void main() {
  test('Riverpod cart: add Keyboard twice, apply SAVE10, total is 88.2', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(cartProvider.notifier);

    final keyboard = catalog.firstWhere((p) => p.id == 'p1');
    notifier.add(keyboard);
    notifier.add(keyboard);
    notifier.applyCoupon('SAVE10');

    final state = container.read(cartProvider);
    expect(state.total, 88.20);
  });

  test('Riverpod cart: checkout exception sets status to failure while keeping lines', () async {
    final mockApi = FailingCheckoutApi();

    final container = ProviderContainer(
      overrides: [
        checkoutApiProvider.overrideWithValue(mockApi),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(cartProvider.notifier);
    final keyboard = catalog.firstWhere((p) => p.id == 'p1');
    notifier.add(keyboard);

    await notifier.checkout();

    final state = container.read(cartProvider);
    expect(state.status, CheckoutStatus.failure);
    expect(state.checkoutError, 'Card declined');
    expect(state.lines.length, 1);
  });
}