import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart.dart';
import '../services/checkout_api.dart';

final checkoutApiProvider = Provider<CheckoutApi>((ref) => CheckoutApi());

class CartNotifier extends Notifier<CartState> {
  final List<CartState> _history = [];

  @override
  CartState build() => const CartState();

  bool get canUndo => _history.isNotEmpty;

  void _pushHistory() {
    _history.add(state);
  }

  void add(Product p) {
    _pushHistory();
    state = state.copyWith(lines: state.lines.withProduct(p));
  }

  void changeQty(String id, int delta) {
    _pushHistory();
    state = state.copyWith(lines: state.lines.changeQty(id, delta));
  }

  void applyCoupon(String code) {
    _pushHistory();
    if (code == 'SAVE10') {
      state = state.copyWith(coupon: code, couponError: null);
    } else {
      state = state.copyWith(
        couponError: code.isEmpty ? 'Enter a code' : 'Invalid coupon',
      );
    }
  }

  void undo() {
    if (_history.isEmpty) return;
    state = _history.removeLast();
  }

  Future<void> checkout() async {
    state = state.copyWith(
      status: CheckoutStatus.submitting,
      checkoutError: null,
    );

    final api = ref.read(checkoutApiProvider);

    try {
      final orderId = await api.submit(state.total);
      _history.clear();
      state = const CartState().copyWith(
        status: CheckoutStatus.success,
        orderId: orderId,
      );
    } on CheckoutException catch (e) {
      state = state.copyWith(
        status: CheckoutStatus.failure,
        checkoutError: e.message,
      );
    }
  }
}

final cartProvider = NotifierProvider<CartNotifier, CartState>(CartNotifier.new);

final canUndoProvider = Provider<bool>((ref) {
  ref.watch(cartProvider);
  return ref.read(cartProvider.notifier).canUndo;
});