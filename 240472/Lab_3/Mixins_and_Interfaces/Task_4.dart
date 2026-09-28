mixin Walker {
  void walk() => print('Walking on land...');
}

mixin Swimmer {
  void swim() => print('Swimming in water...');
}

mixin Flyable {
  void fly() => print('Flying in the air...');
}

class Duck with Walker, Swimmer, Flyable {
  final String name;
  Duck(this.name);
}

void main() {
  var donald = Duck('Donald');
  print('--- ${donald.name} Actions ---');
  donald.walk();
  donald.swim();
  donald.fly();
}