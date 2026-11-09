import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartBody extends StatelessWidget {
  const CartBody({
    super.key,
    required this.state,
    required this.onAdd,
    required this.onQtyChanged,
    required this.onApplyCoupon,
    required this.onCheckout,
  });

  final CartState state;
  final void Function(Product) onAdd;
  final void Function(String productId, int delta) onQtyChanged;
  final void Function(String code) onApplyCoupon;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: state.coupon ?? '');

    return Column(
      children: [
        // Catalog Chips
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 8,
            children: [
              for (final p in catalog)
                ActionChip(
                  label: Text('${p.name} · \$${p.price.toStringAsFixed(0)}'),
                  onPressed: () => onAdd(p),
                ),
            ],
          ),
        ),

        // Cart Item List
        Expanded(
          child: state.lines.isEmpty
              ? const Center(child: Text('Cart is empty'))
              : ListView(
                  children: [
                    for (final l in state.lines)
                      ListTile(
                        key: ValueKey(l.product.id),
                        title: Text(l.product.name),
                        subtitle: Text('\$${l.product.price.toStringAsFixed(2)} × ${l.qty} = \$${l.subtotal.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => onQtyChanged(l.product.id, -1),
                            ),
                            Text('${l.qty}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => onQtyChanged(l.product.id, 1),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
        ),

        // Coupon Code Section (T2)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Coupon Code',
                    hintText: 'Try SAVE10',
                    errorText: state.couponError,
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.tonal(
                onPressed: () => onApplyCoupon(controller.text.trim()),
                child: const Text('Apply'),
              ),
            ],
          ),
        ),

        // Summary Card (T3)
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Items (${state.itemCount}):'),
                    Text('\$${state.subtotal.toStringAsFixed(2)}'),
                  ],
                ),
                if (state.discount > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Discount (10%):', style: TextStyle(color: Colors.green)),
                      Text('-\$${state.discount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green)),
                    ],
                  ),
                ],
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('\$${state.total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.lines.isEmpty || state.status == CheckoutStatus.submitting
                        ? null
                        : onCheckout,
                    child: state.status == CheckoutStatus.submitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('Checkout'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}