import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/cart.dart';
import '../services/checkout_api.dart';
import '../widgets/cart_body.dart';
import 'cart_cubit.dart';

class CubitCartPage extends StatelessWidget {
  const CubitCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(CheckoutApi()),
      child: const _CubitCartView(),
    );
  }
}

class _CubitCartView extends StatelessWidget {
  const _CubitCartView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
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
          title: const Text('Cart · Cubit'),
          actions: [
            BlocSelector<CartCubit, CartState, bool>(
              selector: (state) => state.canUndo,
              builder: (context, canUndo) {
                return IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed: canUndo ? context.read<CartCubit>().undo : null,
                  tooltip: 'Undo',
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  final cubit = context.read<CartCubit>();
                  return CartBody(
                    state: state,
                    onAdd: cubit.add,
                    onQtyChanged: cubit.changeQty,
                    onApplyCoupon: cubit.applyCoupon,
                    onCheckout: cubit.checkout,
                  );
                },
              ),
            ),
            const _CubitSummaryTotal(),
          ],
        ),
      ),
    );
  }
}

/// T3: Rebuilds only when total changes
class _CubitSummaryTotal extends StatelessWidget {
  const _CubitSummaryTotal();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, double>(
      selector: (state) => state.total,
      builder: (context, total) {
        debugPrint('_CubitSummaryTotal rebuilt with total: \$${total.toStringAsFixed(2)}');
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