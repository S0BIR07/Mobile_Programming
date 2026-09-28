import 'dart:math';

abstract class Shape {
  double area();
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
  @override
  double area() => pi * radius * radius;
}

class Rectangle extends Shape {
  final double width;
  final double height;
  Rectangle(this.width, this.height);
  @override
  double area() => width * height;
}

void main() {
  List<Shape> shapes = [
    Circle(5.0),
    Rectangle(4.0, 6.0),
    Circle(2.5),
  ];
  
  for (var shape in shapes) {
    print('${shape.runtimeType} Area: ${shape.area().toStringAsFixed(2)}');
  }
}