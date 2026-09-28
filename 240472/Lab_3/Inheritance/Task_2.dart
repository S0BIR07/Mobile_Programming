class Animal {
  void makeSound() {
    print('The animal makes a generic sound.');
  }
}

class Dog extends Animal {
  @override
  void makeSound() {
    print('Woof! Woof!');
  }
}

void main() {
  Animal genericAnimal = Animal();
  Dog dog = Dog();
  genericAnimal.makeSound();
  dog.makeSound();
}