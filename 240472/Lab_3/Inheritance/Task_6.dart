base class Vehicle {
  final String vin;
  Vehicle(this.vin);
}

final class SecureVault extends Vehicle {
  final String passkey;
  SecureVault(super.vin, this.passkey);
  void unlock() {
    print('Vault $vin unlocked successfully.');
  }
}

void main() {
  var vault = SecureVault('VIN-90812', 'SUPER-SECRET-KEY');
  vault.unlock();
}