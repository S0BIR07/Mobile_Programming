import 'package:flutter/foundation.dart';

class Product {
  const Product({required this.id, required this.name, required this.price});
  final String id;
  final String name;
  final double price;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

const catalog = [
  Product(id: 'p1', name: 'Keyboard', price: 49),
  Product(id: 'p2', name: 'Mouse', price: 25),
  Product(id: 'p3', name: 'Monitor', price: 199),
];

class CartLine {
  const CartLine({required this.product, required this.qty});
  final Product product;
  final int qty;
  double get subtotal => product.price * qty;
  CartLine copyWith({int? qty}) => CartLine(product: product, qty: qty ?? this.qty);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartLine &&
          runtimeType == other.runtimeType &&
          product == other.product &&
          qty == other.qty;

  @override
  int get hashCode => Object.hash(product, qty);
}

extension CartLines on List<CartLine> {
  List<CartLine> withProduct(Product p) {
    final i = indexWhere((l) => l.product.id == p.id);
    if (i == -1) return [...this, CartLine(product: p, qty: 1)];
    return [for (final l in this) l.product.id == p.id ? l.copyWith(qty: l.qty + 1) : l];
  }

  List<CartLine> without(String productId) =>
      [for (final l in this) if (l.product.id != productId) l];

  List<CartLine> changeQty(String productId, int delta) {
    final i = indexWhere((l) => l.product.id == productId);
    if (i == -1) return this;
    final newQty = this[i].qty + delta;
    if (newQty <= 0) return without(productId);
    return [
      for (final l in this)
        l.product.id == productId ? l.copyWith(qty: newQty) : l
    ];
  }

  double get subtotal => fold(0.0, (s, l) => s + l.subtotal);
  int get itemCount => fold(0, (s, l) => s + l.qty);
}

enum CheckoutStatus { idle, submitting, success, failure }

@immutable
class CartState {
  const CartState({
    this.lines = const [],
    this.coupon,
    this.couponError,
    this.status = CheckoutStatus.idle,
    this.orderId,
    this.checkoutError,
    this.history = const [],
    bool? canUndo,
  }) : _canUndoOverride = canUndo;

  final List<CartLine> lines;
  final String? coupon;
  final String? couponError;
  final CheckoutStatus status;
  final String? orderId;
  final String? checkoutError;
  final List<CartState> history;
  final bool? _canUndoOverride;

  bool get canUndo => _canUndoOverride ?? history.isNotEmpty;
  int get itemCount => lines.itemCount;
  double get subtotal => lines.subtotal;
  double get discount => coupon == 'SAVE10' ? subtotal * 0.10 : 0.0;
  double get total => subtotal - discount;

  /// Creates a snapshot without nested history to avoid exponential memory growth
  CartState asSnapshot() => CartState(
        lines: lines,
        coupon: coupon,
        couponError: couponError,
        status: status,
        orderId: orderId,
        checkoutError: checkoutError,
      );

  CartState copyWith({
    List<CartLine>? lines,
    Object? coupon = _sentinel,
    Object? couponError = _sentinel,
    CheckoutStatus? status,
    Object? orderId = _sentinel,
    Object? checkoutError = _sentinel,
    List<CartState>? history,
    Object? canUndo = _sentinel,
  }) {
    return CartState(
      lines: lines ?? this.lines,
      coupon: coupon == _sentinel ? this.coupon : coupon as String?,
      couponError: couponError == _sentinel ? this.couponError : couponError as String?,
      status: status ?? this.status,
      orderId: orderId == _sentinel ? this.orderId : orderId as String?,
      checkoutError: checkoutError == _sentinel ? this.checkoutError : checkoutError as String?,
      history: history ?? this.history,
      canUndo: canUndo == _sentinel ? _canUndoOverride : canUndo as bool?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartState &&
          runtimeType == other.runtimeType &&
          listEquals(lines, other.lines) &&
          coupon == other.coupon &&
          couponError == other.couponError &&
          status == other.status &&
          orderId == other.orderId &&
          checkoutError == other.checkoutError &&
          listEquals(history, other.history) &&
          canUndo == other.canUndo;

  @override
  int get hashCode => Object.hash(
        Object.hashAll(lines),
        coupon,
        couponError,
        status,
        orderId,
        checkoutError,
        Object.hashAll(history),
        canUndo,
      );
}

const Object _sentinel = Object();