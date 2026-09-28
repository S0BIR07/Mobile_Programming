class Shape {
  final String name;
  Shape(this.name);
  void describe() {
    print('Shape Type: $name');
  }
}

class Polygon extends Shape {
  final int numberOfSides;
  Polygon(super.name, this.numberOfSides);
}

class Triangle extends Polygon {
  final double base;
  final double height;
  Triangle(this.base, this.height) : super('Triangle', 3);
  double get area => 0.5 * base * height;
}

void main() {
  var triangle = Triangle(10.0, 5.0);
  triangle.describe();
  print('Sides: ${triangle.numberOfSides}');
  print('Area: ${triangle.area}');
}