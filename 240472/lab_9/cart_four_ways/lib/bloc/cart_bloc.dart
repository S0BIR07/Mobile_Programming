import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/cart.dart';
import '../services/checkout_api.dart';
import 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._api) : super(const CartState()) {
    on<CartProductAdded>(_onProductAdded);
    on<CartProductRemoved>(_onProductRemoved);
    on<CartQtyChanged>(_onQtyChanged);
    on<CartCouponApplied>(_onCouponApplied);
    on<CartUndone>(_onUndone);
    on<CartCheckoutRequested>(
      _onCheckoutRequested,
      transformer: droppable(),
    );
  }

  final CheckoutApi _api;

  /// Exhaustive switch on sealed CartEvent to classify undoable mutations (T5)
  bool _isUndoable(CartEvent event) => switch (event) {
        CartProductAdded() ||
        CartProductRemoved() ||
        CartQtyChanged() ||
        CartCouponApplied() =>
          true,
        CartCheckoutRequested() || CartUndone() => false,
      };

  List<CartState> _nextHistoryFor(CartEvent event) =>
      _isUndoable(event) ? [...state.history, state.asSnapshot()] : state.history;

  void _onProductAdded(CartProductAdded event, Emitter<CartState> emit) {
    emit(state.copyWith(
      lines: state.lines.withProduct(event.product),
      history: _nextHistoryFor(event),
    ));
  }

  void _onProductRemoved(CartProductRemoved event, Emitter<CartState> emit) {
    emit(state.copyWith(
      lines: state.lines.without(event.productId),
      history: _nextHistoryFor(event),
    ));
  }

  void _onQtyChanged(CartQtyChanged event, Emitter<CartState> emit) {
    emit(state.copyWith(
      lines: state.lines.changeQty(event.productId, event.delta),
      history: _nextHistoryFor(event),
    ));
  }

  void _onCouponApplied(CartCouponApplied event, Emitter<CartState> emit) {
    final candidate = event.code == 'SAVE10'
        ? state.copyWith(coupon: event.code, couponError: null)
        : state.copyWith(
            couponError: event.code.isEmpty ? 'Enter a code' : 'Invalid coupon',
          );

    if (candidate == state) return;

    emit(candidate.copyWith(history: _nextHistoryFor(event)));
  }

  void _onUndone(CartUndone event, Emitter<CartState> emit) {
    if (state.history.isEmpty) return;
    final previous = state.history.last;
    final remaining = state.history.sublist(0, state.history.length - 1);
    emit(previous.copyWith(history: remaining));
  }

  Future<void> _onCheckoutRequested(
    CartCheckoutRequested event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(
      status: CheckoutStatus.submitting,
      checkoutError: null,
    ));

    try {
      final orderId = await _api.submit(state.total);
      if (emit.isDone) return; // T4: Guard against emitting after close/completion

      emit(const CartState().copyWith(
        status: CheckoutStatus.success,
        orderId: orderId,
        history: const [],
      ));
    } on CheckoutException catch (e) {
      if (emit.isDone) return;

      emit(state.copyWith(
        status: CheckoutStatus.failure,
        checkoutError: e.message,
      ));
    }
  }
}