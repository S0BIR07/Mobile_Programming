class Car {
  final String brand;
  Car(this.brand);
}

class ElectricCar extends Car {
  final double batteryCapacity;
  ElectricCar(super.brand, this.batteryCapacity);
  void displaySpecs() {
    print('Brand: $brand, Battery: ${batteryCapacity}kWh');
  }
}

void main() {
  var myTesla = ElectricCar('Tesla', 85.5);
  myTesla.displaySpecs();
}