import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../services/checkout_api.dart';
import '../widgets/cart_body.dart';

class SetStateCartPage extends StatefulWidget {
  const SetStateCartPage({super.key});

  @override
  State<SetStateCartPage> createState() => _SetStateCartPageState();
}

class _SetStateCartPageState extends State<SetStateCartPage> {
  CartState _state = const CartState();
  final List<CartState> _history = [];
  final _checkoutApi = CheckoutApi();

  void _pushHistory() {
    _history.add(_state);
  }

  void _add(Product p) {
    setState(() {
      _pushHistory();
      _state = _state.copyWith(lines: _state.lines.withProduct(p));
    });
  }

  void _changeQty(String id, int delta) {
    setState(() {
      _pushHistory();
      _state = _state.copyWith(lines: _state.lines.changeQty(id, delta));
    });
  }

  void _applyCoupon(String code) {
    setState(() {
      _pushHistory();
      if (code == 'SAVE10') {
        _state = _state.copyWith(coupon: code, couponError: null);
      } else {
        _state = _state.copyWith(
          couponError: code.isEmpty ? 'Enter a code' : 'Invalid coupon',
        );
      }
    });
  }

  void _undo() {
    if (_history.isEmpty) return;
    setState(() {
      _state = _history.removeLast();
    });
  }

  Future<void> _checkout() async {
    setState(() {
      _state = _state.copyWith(
        status: CheckoutStatus.submitting,
        checkoutError: null,
      );
    });

    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

    try {
      final orderId = await _checkoutApi.submit(_state.total);
      if (!mounted) return;

      setState(() {
        _history.clear();
        _state = const CartState().copyWith(
          status: CheckoutStatus.success,
          orderId: orderId,
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully: $orderId')),
      );
    } on CheckoutException catch (e) {
      if (!mounted) return;

      setState(() {
        _state = _state.copyWith(
          status: CheckoutStatus.failure,
          checkoutError: e.message,
        );
      });

      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Text('Checkout failed: ${e.message}'),
          actions: [
            TextButton(
              onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
              child: const Text('DISMISS'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart · setState'),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: _history.isEmpty ? null : _undo,
            tooltip: 'Undo',
          ),
        ],
      ),
      body: CartBody(
        state: _state,
        onAdd: _add,
        onQtyChanged: _changeQty,
        onApplyCoupon: _applyCoupon,
        onCheckout: _checkout,
      ),
    );
  }
}