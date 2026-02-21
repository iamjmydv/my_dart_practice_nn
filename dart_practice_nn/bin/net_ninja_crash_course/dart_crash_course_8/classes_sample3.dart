//------------------------------------------------------------------------------
// C L A S S E S  —  S A M P L E  3
//------------------------------------------------------------------------------
//
// Inheritance — extends, override, super
//
// This file covers three core inheritance concepts in Dart:
//   7. Basic inheritance with extends (Vehicle/Truck)
//   8. Overriding methods (Shape/Circle)
//   9. Super keyword (Person/Student)
//
// -----------------------------------------------------------------------
//  #  | TOPIC                          | KEYWORDS USED            | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  7  | Basic inheritance (extends)    | extends, super           | Reuse code from a parent class
//  8  | Overriding methods             | @override                | Change inherited behavior in child class
//  9  | Super keyword                  | super, super.property    | Pass data to the parent constructor
// -----------------------------------------------------------------------
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 7. BASIC INHERITANCE (extends) - Reuse code from a parent
  //    A child class "extends" a parent class to inherit all
  //    its properties and methods. The child can also add its
  //    own properties and methods on top. This avoids repeating
  //    code that is shared between related classes.
  // ============================================================
  var myVehicle = Vehicle('Ford', 120);
  var myTruck = Truck('Volvo', 90, 5000.0);

  print(myVehicle.info()); // Ford going at 120 km/h
  print(myTruck.info()); // Volvo going at 90 km/h  (inherited method)
  print(myTruck.truckInfo()); // Volvo going at 90 km/h - Load: 5000.0 kg

  // ============================================================
  // 8. OVERRIDING METHODS - Change inherited behavior
  //    When a child class needs different behavior for a method
  //    it inherited, use @override to replace it. The @override
  //    annotation tells Dart (and other developers) that you are
  //    intentionally replacing the parent's version.
  // ============================================================
  var genericShape = Shape('polygon');
  var myCircle = Circle(7.0);

  print(genericShape.describe()); // This is a polygon
  print(genericShape.calculateArea()); // 0.0

  print(myCircle.describe()); // This is a circle with radius 7.0  (overridden)
  print(myCircle.calculateArea()); // 153.93791 (overridden with real formula)

  // ============================================================
  // 9. SUPER KEYWORD - Pass data to the parent constructor
  //    When a child class extends a parent, it must provide
  //    values for the parent's constructor. Use "super.property"
  //    in the child's constructor to send values directly to
  //    the parent. The child can also use parent methods.
  // ============================================================
  var teacher = Person('Mr. Smith', 35);
  var learner = Student('Anna', 20, 'MIT', 3.8);

  print(teacher.introduce()); // Hi, I'm Mr. Smith and I'm 35 years old.
  print(learner.introduce()); // Hi, I'm Anna and I'm 20 years old.  (inherited)
  print(learner.studentInfo()); // Hi, I'm Anna and I'm 20 years old. I study at MIT with a GPA of 3.8.
}

// ============================================================
//  CLASS DEFINITIONS
//  (Dart allows class definitions after main — the compiler
//   reads the entire file before running, so order doesn't matter)
// ============================================================

// ---- Section 7: Basic inheritance ----
// Vehicle is the PARENT (or "base") class.
// Truck EXTENDS Vehicle, meaning it inherits brand, speed, and info().
// Truck also adds its own property (loadCapacity) and method (truckInfo()).
// "super.brand" and "super.speed" pass values up to Vehicle's constructor.
class Vehicle {
  String brand;
  int speed;

  Vehicle(this.brand, this.speed);

  String info() {
    return '$brand going at $speed km/h';
  }
}

class Truck extends Vehicle {
  double loadCapacity;

  Truck(super.brand, super.speed, this.loadCapacity);

  String truckInfo() {
    return '${info()} - Load: $loadCapacity kg';
  }
}

// ---- Section 8: Overriding methods ----
// Shape is the parent class with a generic describe() and calculateArea().
// Circle extends Shape and OVERRIDES both methods with its own versions.
// The @override annotation is optional but strongly recommended — it tells
// Dart and other developers you are intentionally replacing the parent method.
// ": super('circle')" passes the name 'circle' to Shape's constructor.
class Shape {
  String name;

  Shape(this.name);

  String describe() {
    return 'This is a $name';
  }

  double calculateArea() {
    return 0.0;
  }
}

class Circle extends Shape {
  double radius;

  Circle(this.radius) : super('circle');

  @override
  String describe() {
    return 'This is a circle with radius $radius';
  }

  @override
  double calculateArea() {
    return 3.14159 * radius * radius;
  }
}

// ---- Section 9: Super keyword ----
// Person is the parent class with name, age, and introduce().
// Student extends Person and adds school and gpa.
// "super.name" and "super.age" forward values to Person(name, age).
// studentInfo() calls the inherited introduce() method and adds more info.
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  String introduce() {
    return "Hi, I'm $name and I'm $age years old.";
  }
}

class Student extends Person {
  String school;
  double gpa;

  // super.name and super.age send values to Person(name, age)
  Student(super.name, super.age, this.school, this.gpa);

  String studentInfo() {
    return "${introduce()} I study at $school with a GPA of $gpa.";
  }
}

// =============================================================================
//  NOTES: Sample 3 — Inheritance: extends, override, super
// =============================================================================
//
//  CONCEPT           | WHAT IT DOES                            | EXAMPLE
// -------------------|-----------------------------------------|--------------------
//  extends           | Child inherits from parent              | class Truck extends Vehicle
//  inherited members | Child gets parent's properties/methods  | myTruck.info()
//  @override         | Replace parent's method in child        | @override String describe()
//  super('value')    | Pass value to parent constructor        | Circle(r) : super('circle')
//  super.property    | Forward constructor arg to parent       | Student(super.name, super.age, ...)
//
//  INHERITANCE HIERARCHY:
//  ┌─────────────────────────────────────────────────────────┐
//  │  Vehicle (parent)            Shape (parent)             │
//  │    ├─ brand, speed             ├─ name                  │
//  │    └─ info()                   ├─ describe()            │
//  │         ↓                      └─ calculateArea()       │
//  │  Truck (child)                      ↓                   │
//  │    ├─ loadCapacity             Circle (child)           │
//  │    └─ truckInfo()               ├─ radius               │
//  │                                 ├─ describe() @override │
//  │  Person (parent)                └─ calculateArea() @o.  │
//  │    ├─ name, age                                         │
//  │    └─ introduce()                                       │
//  │         ↓                                               │
//  │  Student (child)                                        │
//  │    ├─ school, gpa                                       │
//  │    └─ studentInfo()                                     │
//  └─────────────────────────────────────────────────────────┘
//
//  KEY TAKEAWAYS:
//  - "extends" shares code — don't repeat what the parent already has
//  - "@override" replaces — when the child needs different behavior
//  - "super" connects — child sends data to parent's constructor
//  - A child can call parent methods (like introduce() inside studentInfo())
//
// =============================================================================
