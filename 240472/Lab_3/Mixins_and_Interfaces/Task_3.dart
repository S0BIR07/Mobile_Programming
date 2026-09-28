mixin Flyable {
  void fly() {
    print('Flying high in the sky!');
  }
}

class Bird with Flyable {
  final String name;
  Bird(this.name);
}

void main() {
  var sparrow = Bird('Sparrow');
  print('Bird: ${sparrow.name}');
  sparrow.fly();
}