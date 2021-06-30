main() {
  Person toly = Person('toly');
  A a = A(toly);
  B b = B(toly);
  C c = C(toly);

  // print(c.person.name);
  // toly.name = 'toly2';
  // print(c.person.name);

  print(c.person.name);
  toly = Person('toly2');
  print(c.person.name);
}

class A {

  final Person person;

  A(this.person);
}

class B {

  final Person person;

  B(this.person);
}

class C {

  final Person person;

  C(this.person);
}

class Person {
  String name;

  Person(this.name);
}
