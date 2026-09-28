abstract class Animal {
  final String species;
  Animal(this.species);
}

mixin MammalBehavior on Animal {
  void giveBirth() {
    print('Giving birth to live young (Species: $species)...');
  }
}

class Dog extends Animal with MammalBehavior {
  Dog() : super('Canine');
}

void main() {
  var dog = Dog();
  dog.giveBirth();
}