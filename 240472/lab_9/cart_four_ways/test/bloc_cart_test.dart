import 'package:bloc_test/bloc_test.dart';
import 'package:cart_four_ways/bloc/cart_bloc.dart';
import 'package:cart_four_ways/bloc/cart_event.dart';
import 'package:cart_four_ways/models/cart.dart';
import 'package:cart_four_ways/services/checkout_api.dart';
import 'package:flutter_test/flutter_test.dart';

class _SuccessCheckoutApi implements CheckoutApi {
  int callCount = 0;

  @override
  Future<String> submit(double total) async {
    callCount++;
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return 'ORD-1234';
  }
}

class _FailingCheckoutApi implements CheckoutApi {
  @override
  Future<String> submit(double total) async {
    throw const CheckoutException('Card declined');
  }
}

void main() {
  final keyboard = catalog.firstWhere((p) => p.id == 'p1');

  blocTest<CartBloc, CartState>(
    'emits 3 exact states when adding Keyboard twice and applying SAVE10',
    build: () => CartBloc(_SuccessCheckoutApi()),
    act: (bloc) => bloc
      ..add(CartProductAdded(keyboard))
      ..add(CartProductAdded(keyboard))
      ..add(const CartCouponApplied('SAVE10')),
    expect: () => [
      isA<CartState>()
          .having((s) => s.itemCount, 'itemCount', 1)
          .having((s) => s.total, 'total', 49.0),
      isA<CartState>()
          .having((s) => s.itemCount, 'itemCount', 2)
          .having((s) => s.total, 'total', 98.0),
      isA<CartState>()
          .having((s) => s.itemCount, 'itemCount', 2)
          .having((s) => s.coupon, 'coupon', 'SAVE10')
          .having((s) => s.couponError, 'couponError', isNull)
          .having((s) => s.total, 'total', 88.20),
    ],
  );

  blocTest<CartBloc, CartState>(
    'emits submitting followed by failure when checkout throws CheckoutException',
    build: () => CartBloc(_FailingCheckoutApi()),
    seed: () => CartState(lines: [CartLine(product: keyboard, qty: 1)]),
    act: (bloc) => bloc.add(const CartCheckoutRequested()),
    expect: () => [
      CartState(
        lines: [CartLine(product: keyboard, qty: 1)],
        status: CheckoutStatus.submitting,
        checkoutError: null,
      ),
      CartState(
        lines: [CartLine(product: keyboard, qty: 1)],
        status: CheckoutStatus.failure,
        checkoutError: 'Card declined',
      ),
    ],
  );

  blocTest<CartBloc, CartState>(
    'droppable transformer drops duplicate CartCheckoutRequested events while submitting',
    build: () => CartBloc(_SuccessCheckoutApi()),
    seed: () => CartState(lines: [CartLine(product: keyboard, qty: 1)]),
    act: (bloc) => bloc
      ..add(const CartCheckoutRequested())
      ..add(const CartCheckoutRequested()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      CartState(
        lines: [CartLine(product: keyboard, qty: 1)],
        status: CheckoutStatus.submitting,
      ),
      const CartState(
        status: CheckoutStatus.success,
        orderId: 'ORD-1234',
      ),
    ],
  );
}