import 'dart:math' as math;
import 'dart:ui';

main() {
  // List<int> nums = [0, 1, 2, 3, 4, 5, 6, 7,0];
  //
  // List<int> nums1 = nums.where((e) => e > 10).toList();
  // print(nums1);
  //
  // int num2 = nums.singleWhere((e) => e == 0);
  // print(num2);

  // double radius = 10;
  // double area = math.pi*10*10;
  // Shape circle = Circle(radius: 10);
  // double area = circle.getArea();

  Shape triangle = Triangle(
    p0: Offset.zero,
    p1: Offset(2, 0),
    p2: Offset(1, 1),
  );
  double area = triangle.getArea();
  print(area);
}

double getCircle(double radius) {
  return math.pi * radius * radius;
}

abstract class Shape {
  double getArea();
}

class Circle extends Shape {
  final double radius;

  Circle({this.radius = 0});

  @override
  double getArea() {
    return math.pi * radius * radius;
  }
}

class Triangle extends Shape {
  final Offset p0;
  final Offset p1;
  final Offset p2;

  Triangle({
    this.p0 = Offset.zero,
    this.p1 = Offset.zero,
    this.p2 = Offset.zero,
  });

  @override
  double getArea() {
    double a = (p0 - p1).distance;
    double b = (p1 - p2).distance;
    double c = (p2 - p0).distance;

    double s = (a + b + c) / 2;
    double area = math.sqrt(s * (s - a) * (s - b) * (s - c));

    return area;
  }
}
