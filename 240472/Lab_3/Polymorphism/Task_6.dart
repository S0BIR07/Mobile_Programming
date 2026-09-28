abstract interface class PaymentStrategy {
  void pay(double amount);
}

class CreditCardPayment implements PaymentStrategy {
  final String cardNumber;
  CreditCardPayment(this.cardNumber);
  @override
  void pay(double amount) {
    print('Paid \$${amount} using Credit Card (${cardNumber.substring(cardNumber.length - 4)}).');
  }
}

class CryptoPayment implements PaymentStrategy {
  final String walletAddress;
  CryptoPayment(this.walletAddress);
  @override
  void pay(double amount) {
    print('Paid \$${amount} using Crypto Wallet ($walletAddress).');
  }
}

class ShoppingCart {
  PaymentStrategy _paymentStrategy;
  ShoppingCart(this._paymentStrategy);
  set strategy(PaymentStrategy newStrategy) {
    _paymentStrategy = newStrategy;
  }
  void checkout(double total) {
    _paymentStrategy.pay(total);
  }
}

void main() {
  var cart = ShoppingCart(CreditCardPayment('4111222233334444'));
  cart.checkout(99.99);
  cart.strategy = CryptoPayment('0x71C...89');
  cart.checkout(150.00);
}