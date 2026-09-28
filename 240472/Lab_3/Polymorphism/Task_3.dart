abstract class Vehicle {}

class Car extends Vehicle {
  void drive() => print('Car is driving on the road.');
}

class Airplane extends Vehicle {
  void fly() => print('Airplane is flying in the sky.');
}

void performVehicleAction(Vehicle vehicle) {
  if (vehicle is Car) {
    vehicle.drive(); 
  } else if (vehicle is Airplane) {
    vehicle.fly();
  }
}

void main() {
  Vehicle myCar = Car();
  Vehicle myPlane = Airplane();
  performVehicleAction(myCar);
  performVehicleAction(myPlane);
}