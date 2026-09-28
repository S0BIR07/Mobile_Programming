class BankAccount {
  double _balance;
  final String accountNumber;

  BankAccount(this.accountNumber, double initialBalance)
      : _balance = initialBalance >= 0 ? initialBalance : 0 {
    if (initialBalance < 0) {
      print('Warning: Initial balance cannot be negative. Set to 0.');
    }
  }

  double get balance => _balance;

  set balance(double newBalance) {
    if (newBalance < 0) {
      throw ArgumentError('Domain Error: Balance cannot be negative.');
    }
    _balance = newBalance;
  }

  bool get isHealthy => _balance >= 100.0;
}

void main() {
  var account = BankAccount('ACC-10928', 250.0);

  print('Account: ${account.accountNumber}');
  print('Current Balance: \$${account.balance}');
  print('Is Healthy: ${account.isHealthy}');

  account.balance = 500.0;
  print('Updated Balance: \$${account.balance}');

  try {
    account.balance = -50.0;
  } catch (e) {
    print('Caught Expected Error: $e');
  }
}