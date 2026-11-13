import 'package:cart_four_ways/cubit/cart_cubit.dart';
import 'package:cart_four_ways/models/cart.dart';
import 'package:cart_four_ways/services/checkout_api.dart';
import 'package:flutter_test/flutter_test.dart';
class MockCheckoutApi implements CheckoutApi {
  Object? submitError;

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #submit && submitError != null) {
      throw submitError!;
    }
    return super.noSuchMethod(invocation);
  }
}

void main() {
  late MockCheckoutApi mockApi;
  final keyboard = catalog.firstWhere((p) => p.id == 'p1');

  setUp(() {
    mockApi = MockCheckoutApi();
  });

  test(
    'emits 3 exact states when adding Keyboard twice and applying SAVE10',
    () async {
      mockApi = MockCheckoutApi();
      final cubit = CartCubit(mockApi);
      final states = expectLater(
        cubit.stream,
        emitsInOrder([
          CartState(
            lines: [CartLine(product: keyboard, qty: 1)],
            canUndo: true,
          ),
          CartState(
            lines: [CartLine(product: keyboard, qty: 2)],
            canUndo: true,
          ),
          CartState(
            lines: [CartLine(product: keyboard, qty: 2)],
            coupon: 'SAVE10',
            couponError: null,
            canUndo: true,
          ),
        ]),
      );

      cubit.add(keyboard);
      cubit.add(keyboard);
      cubit.applyCoupon('SAVE10');

      await states;
      expect(cubit.state.total, 88.20);
      await cubit.close();
    },
  );

  test(
    'emits submitting followed by failure when checkout throws CheckoutException',
    () async {
      mockApi = MockCheckoutApi();
        mockApi.submitError = const CheckoutException('Card declined');
      final cubit = CartCubit(mockApi)
        ..emit(CartState(lines: [CartLine(product: keyboard, qty: 1)]));
      final states = expectLater(
        cubit.stream,
        emitsInOrder([
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
        ]),
      );

      await cubit.checkout();
      await states;
      await cubit.close();
    },
  );
}