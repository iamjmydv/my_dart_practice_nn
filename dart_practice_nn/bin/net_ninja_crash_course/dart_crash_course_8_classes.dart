//-----------------------------------
//  C L A S S E S
//-----------------------------------
//
// This file covers all major Class and Inheritance concepts in Dart.
// Each section has a numbered header, a short description of what it does,
// and a line explaining when/why to use it.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                             | KEYWORDS USED                  | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Basic class with properties       | class, properties              | Blueprint for creating objects
//  2  | Class with constructor            | this, constructor              | Initialize properties when creating objects
//  3  | Class with methods                | methods, return                | Give objects behavior and actions
//  4  | Named constructors                | ClassName.name()               | Multiple ways to create the same object
//  5  | Private properties                | _underscore                    | Hide internal data from outside access
//  6  | Getters and Setters               | get, set                       | Control how properties are read and written
//  7  | Basic inheritance (extends)       | extends, super                 | Reuse code from a parent class
//  8  | Overriding methods                | @override                      | Change inherited behavior in child class
//  9  | Super keyword                     | super, super.property          | Pass data to the parent constructor
// 10  | Multi-level inheritance           | extends chain                  | Build a hierarchy of related classes
// 11  | Abstract classes                  | abstract                       | Define a contract subclasses must follow
// 12  | Interfaces (implements)           | implements                     | Force a class to implement all methods
// 13  | Mixins                            | mixin, with                    | Share behavior across unrelated classes
// 14  | Static properties and methods     | static                         | Class-level data shared by all instances
// 15  | toString() override               | @override toString()           | Custom string representation of objects
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. BASIC CLASS WITH PROPERTIES - A class is a blueprint
  //    When you create a class, you define what data (properties)
  //    an object will hold. Creating an object from a class is
  //    called "instantiation". Access properties with dot notation.
  // ============================================================
  var apple = Fruit();
  var banana = Fruit();

  print(apple.name); // apple
  print(apple.color); // red
  print(banana.weight); // 0.25

  // ============================================================
  // 2. CLASS WITH CONSTRUCTOR - Initialize properties at creation
  //    A constructor runs when you create an object. Using
  //    "this.property" in the constructor automatically assigns
  //    the argument to the property. This lets you create
  //    objects with different values each time.
  // ============================================================
  var civic = Car('Honda', 'Civic', 2023);
  var corolla = Car('Toyota', 'Corolla', 2024);

  print(civic.brand); // Honda
  print(civic.model); // Civic
  print(corolla.year); // 2024

  // ============================================================
  // 3. CLASS WITH METHODS - Give objects behavior
  //    Methods are functions inside a class. They can access
  //    the object's own properties using their names directly.
  //    Use methods to perform actions or return computed values.
  // ============================================================
  var harryPotter = Book('Harry Potter', 'J.K. Rowling', 400);
  var shortStory = Book('The Gift', 'O. Henry', 50);

  print(harryPotter.summary()); // "Harry Potter" by J.K. Rowling (400 pages)
  print(harryPotter.isLong()); // true (more than 300 pages)
  print(shortStory.isLong()); // false

  // ============================================================
  // 4. NAMED CONSTRUCTORS - Multiple ways to create an object
  //    Sometimes you want to create objects in different ways.
  //    Named constructors use the syntax ClassName.name() and
  //    use an initializer list (: x = value) to set properties.
  // ============================================================
  var pointA = Point(3.0, 4.0);
  var origin = Point.origin();
  var pointB = Point.fromList([10.0, 20.0]);

  print(pointA.display()); // (3.0, 4.0)
  print(origin.display()); // (0.0, 0.0)
  print(pointB.display()); // (10.0, 20.0)

  // ============================================================
  // 5. PRIVATE PROPERTIES - Hide data with underscore prefix
  //    In Dart, adding _ before a property name makes it
  //    "library-private" (only accessible within the same file).
  //    Use private properties to protect data and control access
  //    through methods instead of direct modification.
  // ============================================================
  var savings = BankAccount('Alice', 1000.0);

  savings.deposit(500.0);
  print(savings.checkBalance()); // Alice has $1500.0

  savings.withdraw(200.0);
  print(savings.checkBalance()); // Alice has $1300.0

  savings.withdraw(9999.0); // Insufficient funds!

  // ============================================================
  // 6. GETTERS AND SETTERS - Control property access
  //    Getters let you compute values on the fly (like area).
  //    Setters let you add validation when setting a value.
  //    Use "get" for read access and "set" for write access.
  //    The private _property holds the actual data.
  // ============================================================
  var box = Rectangle(10.0, 5.0);

  print('Area: ${box.area}'); // Area: 50.0
  print('Perimeter: ${box.perimeter}'); // Perimeter: 30.0

  box.width = 20.0; // uses setter (valid, positive value)
  print('New Area: ${box.area}'); // New Area: 100.0

  box.width = -5.0; // setter rejects negative value, keeps 20.0
  print('Still: ${box.width}'); // Still: 20.0

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

  // ============================================================
  // 10. MULTI-LEVEL INHERITANCE - Chain of parent classes
  //     A class can extend another class that itself extends
  //     another class. This creates a hierarchy:
  //     LivingThing -> Animal -> Dog
  //     Each level adds more specific properties and methods,
  //     while inheriting everything from all levels above.
  // ============================================================
  var rex = Dog('Canine', 'German Shepherd');

  print(rex.status()); // Alive  (from LivingThing)
  print(rex.animalInfo()); // Canine - Alive  (from Animal)
  print(rex.dogInfo()); // Canine - Alive - Breed: German Shepherd  (from Dog)

  // ============================================================
  // 11. ABSTRACT CLASSES - Define a contract for subclasses
  //     An abstract class CANNOT be instantiated directly.
  //     It can have abstract methods (no body) that subclasses
  //     MUST implement, and regular methods that are inherited.
  //     Use abstract classes when you want to guarantee that
  //     all subclasses have certain methods.
  // ============================================================
  // var gadget = Appliance('Test');  // ERROR! Can't create abstract class directly

  var washer = WashingMachine('Samsung', 8);
  var heater = Microwave('LG', 1200);

  washer.turnOn(); // Samsung washing machine is now running with 8 kg load.
  washer.turnOff(); // Samsung washing machine stopped.
  heater.turnOn(); // LG microwave is heating at 1200 W.
  heater.turnOff(); // LG microwave stopped.
  print(washer.applianceInfo()); // Appliance by Samsung  (inherited regular method)

  // ============================================================
  // 12. INTERFACES (implements) - Force full implementation
  //     "implements" is different from "extends":
  //     - extends: inherit everything, override what you want
  //     - implements: you MUST provide your own version of
  //       EVERY method and property (nothing is inherited)
  //     A class can implement multiple interfaces at once.
  // ============================================================
  var salesReport = Report('Q4 Sales', 'Revenue increased by 25%.');

  print(salesReport.formatForPrint());
  // === Q4 Sales ===
  // Revenue increased by 25%.

  print(salesReport.formatForShare());
  // Q4 Sales: Revenue increased by 25%.

  // ============================================================
  // 13. MIXINS - Share behavior across unrelated classes
  //     Mixins let you add capabilities to classes without
  //     inheritance. Use "mixin" to define shared behavior
  //     and "with" to apply it. A class can use multiple
  //     mixins. Great for abilities like "can fly", "can swim".
  // ============================================================
  var mallard = Duck('Mallard');
  var hero = Superhero('Aquaman');

  print(mallard.abilities()); // Mallard: I can fly! I can swim!
  print(hero.abilities()); // Aquaman: I can fly! I can swim! I can run!

  // ============================================================
  // 14. STATIC PROPERTIES AND METHODS - Belong to the class
  //     Static members belong to the class itself, NOT to
  //     any instance. Access them using ClassName.member.
  //     Use static for constants, counters, or utility methods
  //     that don't depend on instance data.
  // ============================================================
  print(MathHelper.pi); // 3.14159
  print(MathHelper.circleArea(5.0)); // 78.53975
  print(MathHelper.celsiusToFahrenheit(100.0)); // 212.0

  var helperOne = MathHelper();
  var helperTwo = MathHelper();
  print(helperOne.runtimeType); // MathHelper
  print(helperTwo.runtimeType); // MathHelper
  print('Instances created: ${MathHelper.instanceCount}'); // Instances created: 2

  // ============================================================
  // 15. toString() OVERRIDE - Custom string representation
  //     By default, print(object) shows "Instance of 'ClassName'".
  //     Override toString() to show useful info instead.
  //     This is called automatically by print() and string
  //     interpolation ($object or ${object}).
  // ============================================================
  var laptop = Product('MacBook Pro', 1999.99, 'Electronics');
  var shirt = Product('T-Shirt', 29.99, 'Clothing');

  print(laptop); // Product(MacBook Pro, $1999.99, Electronics)
  print(shirt); // Product(T-Shirt, $29.99, Clothing)
  print('I bought a $laptop'); // I bought a Product(MacBook Pro, $1999.99, Electronics)

  // ============================================================
  // NOTES: Class & Inheritance Concepts Used in This File
  // ============================================================
  //  1. class + properties         — define a blueprint with default values
  //  2. constructor (this.)        — initialize properties when creating objects
  //  3. methods                    — functions inside a class that give objects behavior
  //  4. named constructors         — alternative ways to create objects (ClassName.name())
  //  5. private (_underscore)      — restrict access to properties within the same file
  //  6. get / set                  — computed properties and validated assignments
  //  7. extends                    — inherit properties and methods from a parent class
  //  8. @override                  — replace an inherited method with a new version
  //  9. super                      — pass values to the parent class constructor
  // 10. multi-level inheritance    — chain of classes (A -> B -> C) each adding more
  // 11. abstract class             — cannot be instantiated, forces subclasses to implement
  // 12. implements                 — must provide your own version of ALL methods
  // 13. mixin / with              — share behavior across unrelated classes
  // 14. static                     — class-level members, accessed via ClassName.member
  // 15. toString()                 — custom string output when printing an object
  // ============================================================
}

// ============================================================
//  CLASS DEFINITIONS
//  (Dart allows class definitions after main — the compiler
//   reads the entire file before running, so order doesn't matter)
// ============================================================

// ---- Section 1: Basic class with default properties ----
class Fruit {
  String name = 'apple';
  String color = 'red';
  double weight = 0.25;
}

// ---- Section 2: Class with constructor ----
class Car {
  String brand;
  String model;
  int year;

  Car(this.brand, this.model, this.year);
}

// ---- Section 3: Class with methods ----
class Book {
  String title;
  String author;
  int pages;

  Book(this.title, this.author, this.pages);

  String summary() {
    return '"$title" by $author ($pages pages)';
  }

  bool isLong() {
    return pages > 300;
  }
}

// ---- Section 4: Named constructors ----
class Point {
  double x;
  double y;

  // Default constructor
  Point(this.x, this.y);

  // Named constructor: creates a point at (0, 0)
  Point.origin()
      : x = 0,
        y = 0;

  // Named constructor: creates a point from a list
  Point.fromList(List<double> coords)
      : x = coords[0],
        y = coords[1];

  String display() {
    return '($x, $y)';
  }
}

// ---- Section 5: Private properties ----
class BankAccount {
  String owner;
  double _balance; // private (only accessible within this file)

  BankAccount(this.owner, this._balance);

  void deposit(double amount) {
    _balance += amount;
  }

  void withdraw(double amount) {
    if (amount <= _balance) {
      _balance -= amount;
    } else {
      print('Insufficient funds!');
    }
  }

  String checkBalance() {
    return '$owner has \$$_balance';
  }
}

// ---- Section 6: Getters and Setters ----
class Rectangle {
  double _width; // private backing field
  double _height; // private backing field

  Rectangle(this._width, this._height);

  // Getters — read computed or stored values
  double get width => _width;
  double get height => _height;
  double get area => _width * _height;
  double get perimeter => 2 * (_width + _height);

  // Setters — validate before assigning
  set width(double value) {
    if (value > 0) _width = value;
  }

  set height(double value) {
    if (value > 0) _height = value;
  }
}

// ---- Section 7: Basic inheritance ----
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

// ---- Section 10: Multi-level inheritance ----
class LivingThing {
  bool isAlive = true;

  String status() {
    return isAlive ? 'Alive' : 'Not alive';
  }
}

class Animal extends LivingThing {
  String species;

  Animal(this.species);

  String animalInfo() {
    return '$species - ${status()}';
  }
}

class Dog extends Animal {
  String breed;

  Dog(super.species, this.breed);

  String dogInfo() {
    return '${animalInfo()} - Breed: $breed';
  }
}

// ---- Section 11: Abstract classes ----
abstract class Appliance {
  String brand;

  Appliance(this.brand);

  // Abstract methods — no body, subclasses MUST implement these
  void turnOn();
  void turnOff();

  // Regular method — inherited as-is by all subclasses
  String applianceInfo() {
    return 'Appliance by $brand';
  }
}

class WashingMachine extends Appliance {
  int loadKg;

  WashingMachine(super.brand, this.loadKg);

  @override
  void turnOn() {
    print('$brand washing machine is now running with $loadKg kg load.');
  }

  @override
  void turnOff() {
    print('$brand washing machine stopped.');
  }
}

class Microwave extends Appliance {
  int watts;

  Microwave(super.brand, this.watts);

  @override
  void turnOn() {
    print('$brand microwave is heating at $watts W.');
  }

  @override
  void turnOff() {
    print('$brand microwave stopped.');
  }
}

// ---- Section 12: Interfaces (implements) ----
abstract class Printable {
  String formatForPrint();
}

abstract class Shareable {
  String formatForShare();
}

class Report implements Printable, Shareable {
  String title;
  String content;

  Report(this.title, this.content);

  @override
  String formatForPrint() {
    return '=== $title ===\n$content';
  }

  @override
  String formatForShare() {
    return '$title: $content';
  }
}

// ---- Section 13: Mixins ----
mixin CanFly {
  String fly() => 'I can fly!';
}

mixin CanSwim {
  String swim() => 'I can swim!';
}

mixin CanRun {
  String run() => 'I can run!';
}

class Duck with CanFly, CanSwim {
  String name;
  Duck(this.name);

  String abilities() {
    return '$name: ${fly()} ${swim()}';
  }
}

class Superhero with CanFly, CanSwim, CanRun {
  String name;
  Superhero(this.name);

  String abilities() {
    return '$name: ${fly()} ${swim()} ${run()}';
  }
}

// ---- Section 14: Static properties and methods ----
class MathHelper {
  static const double pi = 3.14159;
  static int instanceCount = 0;

  MathHelper() {
    instanceCount++;
  }

  static double circleArea(double radius) {
    return pi * radius * radius;
  }

  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }
}

// ---- Section 15: toString() override ----
class Product {
  String name;
  double price;
  String category;

  Product(this.name, this.price, this.category);

  @override
  String toString() {
    return 'Product($name, \$$price, $category)';
  }
}

// =============================================================================
//  NOTES: Class & Inheritance — Complete Summary
// =============================================================================
//
//  #  | TOPIC                          | WHAT IT TEACHES
// ----|--------------------------------|-------------------------------------------
//  1  | Basic class with properties    | Fruit — creating objects from a blueprint
//  2  | Class with constructor         | Car — this.property shorthand
//  3  | Class with methods             | Book — summary(), isLong()
//  4  | Named constructors             | Point — Point.origin(), Point.fromList()
//  5  | Private properties             | BankAccount — _balance with deposit/withdraw
//  6  | Getters and Setters            | Rectangle — computed area, validated width
//  7  | Basic inheritance              | Vehicle -> Truck with extends
//  8  | Overriding methods             | Shape -> Circle with @override
//  9  | Super keyword                  | Person -> Student with super.name
// 10  | Multi-level inheritance        | LivingThing -> Animal -> Dog
// 11  | Abstract classes               | Appliance -> WashingMachine, Microwave
// 12  | Interfaces (implements)        | Printable, Shareable -> Report
// 13  | Mixins                         | CanFly, CanSwim, CanRun -> Duck, Superhero
// 14  | Static properties/methods      | MathHelper with class-level pi, instanceCount
// 15  | toString() override            | Product with custom print output
// ----|--------------------------------|-------------------------------------------
//
//  All old commented-out examples were removed and replaced with unique class
//  names across all sections to avoid conflicts. Each section has a clear
//  explanation header and a notes summary at the bottom.
//
// =============================================================================
