import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/cart.dart';
import '../services/checkout_api.dart';
import '../widgets/cart_body.dart';
import 'cart_bloc.dart';
import 'cart_event.dart';

class BlocCartPage extends StatelessWidget {
  const BlocCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartBloc(CheckoutApi()),
      child: const _BlocCartView(),
    );
  }
}

class _BlocCartView extends StatelessWidget {
  const _BlocCartView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == CheckoutStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order placed successfully: ${state.orderId}')),
          );
        } else if (state.status == CheckoutStatus.failure) {
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text('Checkout failed: ${state.checkoutError}'),
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart · Bloc'),
          actions: [
            BlocSelector<CartBloc, CartState, bool>(
              selector: (state) => state.canUndo,
              builder: (context, canUndo) {
                return IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed: canUndo
                      ? () => context.read<CartBloc>().add(const CartUndone())
                      : null,
                  tooltip: 'Undo',
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  final bloc = context.read<CartBloc>();
                  return CartBody(
                    state: state,
                    onAdd: (p) => bloc.add(CartProductAdded(p)),
                    onQtyChanged: (id, delta) =>
                        bloc.add(CartQtyChanged(id, delta)),
                    onApplyCoupon: (code) =>
                        bloc.add(CartCouponApplied(code)),
                    onCheckout: () => bloc.add(const CartCheckoutRequested()),
                  );
                },
              ),
            ),
            const _BlocSummaryTotal(),
          ],
        ),
      ),
    );
  }
}

/// T3: Reuses BlocSelector pattern parameterised on CartBloc
class _BlocSummaryTotal extends StatelessWidget {
  const _BlocSummaryTotal();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartBloc, CartState, double>(
      selector: (state) => state.total,
      builder: (context, total) {
        debugPrint('_BlocSummaryTotal rebuilt with total: \$${total.toStringAsFixed(2)}');
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
      },
    );
  }
}