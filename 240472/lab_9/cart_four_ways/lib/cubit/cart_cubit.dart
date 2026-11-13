import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart.dart';
import '../services/checkout_api.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._api) : super(const CartState());

  final CheckoutApi _api;
  final List<CartState> _history = [];

  @override
  void onChange(Change<CartState> change) {
    super.onChange(change);
    debugPrint('CartCubit onChange: ${change.currentState.coupon} -> ${change.nextState.coupon}');
  }

  void _pushHistory() {
    _history.add(state);
  }

  void add(Product p) {
    _pushHistory();
    emit(state.copyWith(
      lines: state.lines.withProduct(p),
      canUndo: _history.isNotEmpty,
    ));
  }

  void changeQty(String id, int delta) {
    _pushHistory();
    emit(state.copyWith(
      lines: state.lines.changeQty(id, delta),
      canUndo: _history.isNotEmpty,
    ));
  }

  void applyCoupon(String code) {
    // Compute candidate state first; if equal to current state, skip pushing duplicate history
    final nextState = code == 'SAVE10'
        ? state.copyWith(coupon: code, couponError: null)
        : state.copyWith(
            couponError: code.isEmpty ? 'Enter a code' : 'Invalid coupon',
          );

    if (nextState == state) {
      // emit() would also drop this automatically due to == equality
      emit(nextState);
      return;
    }

    _pushHistory();
    emit(nextState.copyWith(canUndo: _history.isNotEmpty));
  }

  void undo() {
    if (_history.isEmpty) return;
    final previous = _history.removeLast();
    emit(previous.copyWith(canUndo: _history.isNotEmpty));
  }

  Future<void> checkout() async {
    emit(state.copyWith(
      status: CheckoutStatus.submitting,
      checkoutError: null,
    ));

    try {
      final orderId = await _api.submit(state.total);
      if (isClosed) return; // T4: Prevent emit after cubit disposal

      _history.clear();
      emit(const CartState().copyWith(
        status: CheckoutStatus.success,
        orderId: orderId,
        canUndo: false,
      ));
    } on CheckoutException catch (e) {
      if (isClosed) return; // T4: Prevent emit after cubit disposal

      emit(state.copyWith(
        status: CheckoutStatus.failure,
        checkoutError: e.message,
      ));
    }
  }
}