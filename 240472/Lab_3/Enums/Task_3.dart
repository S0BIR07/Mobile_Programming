enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}

String getStatus(OrderStatus status) {
  return switch (status) {
    OrderStatus.pending => 'Order Placed - Awaiting Confirmation',
    OrderStatus.processing => 'Processing Your Order',
    OrderStatus.shipped => 'Package is On The Way',
    OrderStatus.delivered => 'Delivered Successfully',
    OrderStatus.cancelled => 'Order Cancelled',
  };
}

void main() {
  OrderStatus currentStatus = OrderStatus.shipped;
  
  String uiMessage = getStatus(currentStatus);
  print('UI Display: $uiMessage');
}