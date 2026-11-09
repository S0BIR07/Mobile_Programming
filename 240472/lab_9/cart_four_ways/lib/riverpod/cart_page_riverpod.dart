import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart.dart';
import '../widgets/cart_body.dart';
import 'cart_notifier.dart';

class RiverpodCartPage extends ConsumerWidget {
  const RiverpodCartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cartProvider);
    final cart = ref.read(cartProvider.notifier);
    final canUndo = ref.watch(canUndoProvider);

    ref.listen<CheckoutStatus>(
      cartProvider.select((s) => s.status),
      (prev, next) {
        if (next == CheckoutStatus.success) {
          final orderId = ref.read(cartProvider).orderId;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order placed successfully: $orderId')),
          );
        } else if (next == CheckoutStatus.failure) {
          final error = ref.read(cartProvider).checkoutError;
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text('Checkout failed: $error'),
              actions: [
                TextButton(
                  onPressed: () => ScaffoldMessenger.of(context)
                      .hideCurrentMaterialBanner(),
                  child: const Text('DISMISS'),
                ),
              ],
            ),
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart · Riverpod'),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: canUndo ? cart.undo : null,
            tooltip: 'Undo',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CartBody(
              state: state,
              onAdd: cart.add,
              onQtyChanged: cart.changeQty,
              onApplyCoupon: cart.applyCoupon,
              onCheckout: cart.checkout,
            ),
          ),
          // T3 Derived value ConsumerWidget section
          const SummaryTotalWidget(),
        ],
      ),
    );
  }
}

class SummaryTotalWidget extends ConsumerWidget {
  const SummaryTotalWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(cartProvider.select((s) => s.total));
    debugPrint('SummaryTotalWidget rebuilt with total: \$${total.toStringAsFixed(2)}');

    return Container(
      padding: const EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Scoped Selection Total:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}