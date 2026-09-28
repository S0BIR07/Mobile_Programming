abstract class PaymentProcessor {
  void logTransaction(double amount) {
    print('Processing transaction of \$${amount.toStringAsFixed(2)}...');
  }
  bool processPayment(double amount);
}

class CreditCardPayment extends PaymentProcessor {
  final String cardNumber;
  CreditCardPayment(this.cardNumber);
  @override
  bool processPayment(double amount) {
    logTransaction(amount);
    print('Charged \$${amount} to Card ending in ${cardNumber.substring(cardNumber.length - 4)}');
    return true;
  }
}

void main() {
  PaymentProcessor payment = CreditCardPayment('4532111122228888');
  payment.processPayment(150.0);
}