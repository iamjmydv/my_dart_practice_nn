//------------------------------------------------------------------------------
// C L A S S E S  —  C O M P L E T E  G U I D E
//------------------------------------------------------------------------------
//
// This file combines ALL 5 samples into one runnable file.
// Classes in Dart are blueprints for creating objects —
// they define what data (properties) an object holds and what
// actions (methods) it can perform.
//
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
// NOTE: All class names are PREFIXED (S1Fruit, S2Point, S3Vehicle, etc.)
//       to avoid naming collisions since all classes live in one file.
//
// -----------------------------------------------------------------------

void main() {
  // ============================================================
  //  Uncomment/comment any sample to run only what you want.
  //  Each sample is independent — they don't depend on each other.
  // ============================================================

  sample1BasicClassConstructorMethods();
  sample2NamedConstructorsPrivateGettersSetters();
  sample3InheritanceExtendsOverrideSuper();
  sample4MultiLevelAbstractInterfaces();
  sample5MixinsStaticToString();
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  1:  BASIC CLASS, CONSTRUCTOR & METHODS
//
//  Classes are blueprints for creating objects.
//  A constructor initializes properties when an object is created.
//  Methods are functions inside a class that give objects behavior.
//
//  Think of a class like a cookie cutter — the cutter is the class,
//  and each cookie you make is an object (instance).
//
// =============================================================================
// =============================================================================

void sample1BasicClassConstructorMethods() {
  print('');
  print('##############################################');
  print('# SAMPLE 1: Basic Class, Constructor & Methods #');
  print('##############################################');

  // ============================================================
  // 1. BASIC CLASS WITH PROPERTIES - A class is a blueprint
  //    When you create a class, you define what data (properties)
  //    an object will hold. Creating an object from a class is
  //    called "instantiation". Access properties with dot notation.
  // ============================================================
  var apple = S1Fruit();
  var banana = S1Fruit();

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
  var civic = S1Car('Honda', 'Civic', 2023);
  var corolla = S1Car('Toyota', 'Corolla', 2024);

  print(civic.brand); // Honda
  print(civic.model); // Civic
  print(corolla.year); // 2024

  // ============================================================
  // 3. CLASS WITH METHODS - Give objects behavior
  //    Methods are functions inside a class. They can access
  //    the object's own properties using their names directly.
  //    Use methods to perform actions or return computed values.
  // ============================================================
  var harryPotter = S1Book('Harry Potter', 'J.K. Rowling', 400);
  var shortStory = S1Book('The Gift', 'O. Henry', 50);

  print(harryPotter.summary()); // "Harry Potter" by J.K. Rowling (400 pages)
  print(harryPotter.isLong()); // true (more than 300 pages)
  print(shortStory.isLong()); // false
  print('');
}

// --- Sample 1: Class definitions ---

class S1Fruit {
  String name = 'apple';
  String color = 'red';
  double weight = 0.25;
}

class S1Car {
  String brand;
  String model;
  int year;

  S1Car(this.brand, this.model, this.year);
}

class S1Book {
  String title;
  String author;
  int pages;

  S1Book(this.title, this.author, this.pages);

  String summary() {
    return '"$title" by $author ($pages pages)';
  }

  bool isLong() {
    return pages > 300;
  }
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  2:  NAMED CONSTRUCTORS, PRIVATE PROPERTIES & GETTERS/SETTERS
//
//  Named constructors provide alternative ways to create objects.
//  Private properties (with _ prefix) hide data from external access.
//  Getters and setters control how properties are read and written.
//
//  Think of private properties like a bank vault —
//  you can't reach in directly; you must go through the teller (methods).
//
// =============================================================================
// =============================================================================

void sample2NamedConstructorsPrivateGettersSetters() {
  print('##############################################');
  print('# SAMPLE 2: Named Constructors, Private, G/S  #');
  print('##############################################');

  // ============================================================
  // 4. NAMED CONSTRUCTORS - Multiple ways to create an object
  //    Sometimes you want to create objects in different ways.
  //    Named constructors use the syntax ClassName.name() and
  //    use an initializer list (: x = value) to set properties.
  // ============================================================
  var pointA = S2Point(3.0, 4.0);
  var origin = S2Point.origin();
  var pointB = S2Point.fromList([10.0, 20.0]);

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
  var savings = S2BankAccount('Alice', 1000.0);

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
  var box = S2Rectangle(10.0, 5.0);

  print('Area: ${box.area}'); // Area: 50.0
  print('Perimeter: ${box.perimeter}'); // Perimeter: 30.0

  box.width = 20.0; // uses setter (valid, positive value)
  print('New Area: ${box.area}'); // New Area: 100.0

  box.width = -5.0; // setter rejects negative value, keeps 20.0
  print('Still: ${box.width}'); // Still: 20.0
  print('');
}

// --- Sample 2: Class definitions ---

class S2Point {
  double x;
  double y;

  S2Point(this.x, this.y);

  S2Point.origin()
      : x = 0,
        y = 0;

  S2Point.fromList(List<double> coords)
      : x = coords[0],
        y = coords[1];

  String display() {
    return '($x, $y)';
  }
}

class S2BankAccount {
  String owner;
  double _balance;

  S2BankAccount(this.owner, this._balance);

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

class S2Rectangle {
  double _width;
  double _height;

  S2Rectangle(this._width, this._height);

  double get width => _width;
  double get height => _height;
  double get area => _width * _height;
  double get perimeter => 2 * (_width + _height);

  set width(double value) {
    if (value > 0) _width = value;
  }

  set height(double value) {
    if (value > 0) _height = value;
  }
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  3:  INHERITANCE — extends, override, super
//
//  Inheritance lets a child class reuse code from a parent class.
//  @override replaces a parent method with a new version.
//  super passes data from the child to the parent constructor.
//
//  Think of inheritance like a family tree —
//  children inherit traits from their parents, but can also have their own.
//
// =============================================================================
// =============================================================================

void sample3InheritanceExtendsOverrideSuper() {
  print('##############################################');
  print('# SAMPLE 3: Inheritance (extends/override/super) #');
  print('##############################################');

  // ============================================================
  // 7. BASIC INHERITANCE (extends) - Reuse code from a parent
  //    A child class "extends" a parent class to inherit all
  //    its properties and methods. The child can also add its
  //    own properties and methods on top. This avoids repeating
  //    code that is shared between related classes.
  // ============================================================
  var myVehicle = S3Vehicle('Ford', 120);
  var myTruck = S3Truck('Volvo', 90, 5000.0);

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
  var genericShape = S3Shape('polygon');
  var myCircle = S3Circle(7.0);

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
  var teacher = S3Person('Mr. Smith', 35);
  var learner = S3Student('Anna', 20, 'MIT', 3.8);

  print(teacher.introduce()); // Hi, I'm Mr. Smith and I'm 35 years old.
  print(learner.introduce()); // Hi, I'm Anna and I'm 20 years old.  (inherited)
  print(learner.studentInfo()); // Hi, I'm Anna and I'm 20 years old. I study at MIT with a GPA of 3.8.
  print('');
}

// --- Sample 3: Class definitions ---

class S3Vehicle {
  String brand;
  int speed;

  S3Vehicle(this.brand, this.speed);

  String info() {
    return '$brand going at $speed km/h';
  }
}

class S3Truck extends S3Vehicle {
  double loadCapacity;

  S3Truck(super.brand, super.speed, this.loadCapacity);

  String truckInfo() {
    return '${info()} - Load: $loadCapacity kg';
  }
}

class S3Shape {
  String name;

  S3Shape(this.name);

  String describe() {
    return 'This is a $name';
  }

  double calculateArea() {
    return 0.0;
  }
}

class S3Circle extends S3Shape {
  double radius;

  S3Circle(this.radius) : super('circle');

  @override
  String describe() {
    return 'This is a circle with radius $radius';
  }

  @override
  double calculateArea() {
    return 3.14159 * radius * radius;
  }
}

class S3Person {
  String name;
  int age;

  S3Person(this.name, this.age);

  String introduce() {
    return "Hi, I'm $name and I'm $age years old.";
  }
}

class S3Student extends S3Person {
  String school;
  double gpa;

  S3Student(super.name, super.age, this.school, this.gpa);

  String studentInfo() {
    return "${introduce()} I study at $school with a GPA of $gpa.";
  }
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  4:  MULTI-LEVEL INHERITANCE, ABSTRACT & INTERFACES
//
//  Multi-level inheritance builds chains: A -> B -> C.
//  Abstract classes define contracts that subclasses must follow.
//  Interfaces (implements) force a class to write all methods itself.
//
//  Think of abstract classes like a job description —
//  it lists what you MUST be able to do, but each person does it differently.
//
// =============================================================================
// =============================================================================

void sample4MultiLevelAbstractInterfaces() {
  print('##############################################');
  print('# SAMPLE 4: Multi-level, Abstract & Interfaces #');
  print('##############################################');

  // ============================================================
  // 10. MULTI-LEVEL INHERITANCE - Chain of parent classes
  //     A class can extend another class that itself extends
  //     another class. This creates a hierarchy:
  //     LivingThing -> Animal -> Dog
  //     Each level adds more specific properties and methods,
  //     while inheriting everything from all levels above.
  // ============================================================
  var rex = S4Dog('Canine', 'German Shepherd');

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
  // var gadget = S4Appliance('Test');  // ERROR! Can't create abstract class directly

  var washer = S4WashingMachine('Samsung', 8);
  var heater = S4Microwave('LG', 1200);

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
  var salesReport = S4Report('Q4 Sales', 'Revenue increased by 25%.');

  print(salesReport.formatForPrint());
  // === Q4 Sales ===
  // Revenue increased by 25%.

  print(salesReport.formatForShare());
  // Q4 Sales: Revenue increased by 25%.
  print('');
}

// --- Sample 4: Class definitions ---

class S4LivingThing {
  bool isAlive = true;

  String status() {
    return isAlive ? 'Alive' : 'Not alive';
  }
}

class S4Animal extends S4LivingThing {
  String species;

  S4Animal(this.species);

  String animalInfo() {
    return '$species - ${status()}';
  }
}

class S4Dog extends S4Animal {
  String breed;

  S4Dog(super.species, this.breed);

  String dogInfo() {
    return '${animalInfo()} - Breed: $breed';
  }
}

abstract class S4Appliance {
  String brand;

  S4Appliance(this.brand);

  void turnOn();
  void turnOff();

  String applianceInfo() {
    return 'Appliance by $brand';
  }
}

class S4WashingMachine extends S4Appliance {
  int loadKg;

  S4WashingMachine(super.brand, this.loadKg);

  @override
  void turnOn() {
    print('$brand washing machine is now running with $loadKg kg load.');
  }

  @override
  void turnOff() {
    print('$brand washing machine stopped.');
  }
}

class S4Microwave extends S4Appliance {
  int watts;

  S4Microwave(super.brand, this.watts);

  @override
  void turnOn() {
    print('$brand microwave is heating at $watts W.');
  }

  @override
  void turnOff() {
    print('$brand microwave stopped.');
  }
}

abstract class S4Printable {
  String formatForPrint();
}

abstract class S4Shareable {
  String formatForShare();
}

class S4Report implements S4Printable, S4Shareable {
  String title;
  String content;

  S4Report(this.title, this.content);

  @override
  String formatForPrint() {
    return '=== $title ===\n$content';
  }

  @override
  String formatForShare() {
    return '$title: $content';
  }
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  5:  MIXINS, STATIC & toString
//
//  Mixins add capabilities to classes without inheritance.
//  Static members belong to the class itself, not to instances.
//  toString() gives objects a custom string representation.
//
//  Think of mixins like adding power-ups in a video game —
//  any character can pick up "fly" or "swim" abilities.
//
// =============================================================================
// =============================================================================

void sample5MixinsStaticToString() {
  print('##############################################');
  print('# SAMPLE 5: Mixins, Static & toString         #');
  print('##############################################');

  // ============================================================
  // 13. MIXINS - Share behavior across unrelated classes
  //     Mixins let you add capabilities to classes without
  //     inheritance. Use "mixin" to define shared behavior
  //     and "with" to apply it. A class can use multiple
  //     mixins. Great for abilities like "can fly", "can swim".
  // ============================================================
  var mallard = S5Duck('Mallard');
  var hero = S5Superhero('Aquaman');

  print(mallard.abilities()); // Mallard: I can fly! I can swim!
  print(hero.abilities()); // Aquaman: I can fly! I can swim! I can run!

  // ============================================================
  // 14. STATIC PROPERTIES AND METHODS - Belong to the class
  //     Static members belong to the class itself, NOT to
  //     any instance. Access them using ClassName.member.
  //     Use static for constants, counters, or utility methods
  //     that don't depend on instance data.
  // ============================================================
  print(S5MathHelper.pi); // 3.14159
  print(S5MathHelper.circleArea(5.0)); // 78.53975
  print(S5MathHelper.celsiusToFahrenheit(100.0)); // 212.0

  var helperOne = S5MathHelper();
  var helperTwo = S5MathHelper();
  print(helperOne.runtimeType); // S5MathHelper
  print(helperTwo.runtimeType); // S5MathHelper
  print('Instances created: ${S5MathHelper.instanceCount}'); // Instances created: 2

  // ============================================================
  // 15. toString() OVERRIDE - Custom string representation
  //     By default, print(object) shows "Instance of 'ClassName'".
  //     Override toString() to show useful info instead.
  //     This is called automatically by print() and string
  //     interpolation ($object or ${object}).
  // ============================================================
  var laptop = S5Product('MacBook Pro', 1999.99, 'Electronics');
  var shirt = S5Product('T-Shirt', 29.99, 'Clothing');

  print(laptop); // S5Product(MacBook Pro, $1999.99, Electronics)
  print(shirt); // S5Product(T-Shirt, $29.99, Clothing)
  print('I bought a $laptop'); // I bought a S5Product(MacBook Pro, $1999.99, Electronics)
  print('');
}

// --- Sample 5: Class definitions ---

mixin S5CanFly {
  String fly() => 'I can fly!';
}

mixin S5CanSwim {
  String swim() => 'I can swim!';
}

mixin S5CanRun {
  String run() => 'I can run!';
}

class S5Duck with S5CanFly, S5CanSwim {
  String name;
  S5Duck(this.name);

  String abilities() {
    return '$name: ${fly()} ${swim()}';
  }
}

class S5Superhero with S5CanFly, S5CanSwim, S5CanRun {
  String name;
  S5Superhero(this.name);

  String abilities() {
    return '$name: ${fly()} ${swim()} ${run()}';
  }
}

class S5MathHelper {
  static const double pi = 3.14159;
  static int instanceCount = 0;

  S5MathHelper() {
    instanceCount++;
  }

  static double circleArea(double radius) {
    return pi * radius * radius;
  }

  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }
}

class S5Product {
  String name;
  double price;
  String category;

  S5Product(this.name, this.price, this.category);

  @override
  String toString() {
    return 'Product($name, \$$price, $category)';
  }
}

// =============================================================================
// =============================================================================
//  NOTES: Classes & Inheritance — Complete Summary of ALL 5 Samples
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | TOPIC                          | KEY CONCEPTS
//  -----------------------------------------------------------------------
//   1  | Basic class with properties    | class, properties, default values
//   2  | Class with constructor         | this.property shorthand, initialization
//   3  | Class with methods             | methods, return values, behavior
//   4  | Named constructors             | ClassName.name(), initializer list
//   5  | Private properties             | _underscore, library-private access
//   6  | Getters and Setters            | get (computed), set (validated), backing field
//   7  | Basic inheritance              | extends, child inherits parent's code
//   8  | Overriding methods             | @override, replace parent's method
//   9  | Super keyword                  | super.property, pass data to parent
//  10  | Multi-level inheritance        | extends chain, hierarchy of classes
//  11  | Abstract classes               | abstract, contract, can't instantiate
//  12  | Interfaces (implements)        | implements, must write all methods
//  13  | Mixins                         | mixin, with, shared abilities
//  14  | Static properties/methods      | static, class-level, ClassName.member
//  15  | toString() override            | custom print output, string interpolation
//  -----------------------------------------------------------------------
//
//  EXTENDS vs IMPLEMENTS vs MIXIN — Comparison Table:
//  ┌────────────────────────────────────────────────────────────────┐
//  │  extends              │  implements          │  with (mixin)   │
//  ├───────────────────────┼──────────────────────┼─────────────────┤
//  │  Inherit parent code  │  Write ALL code      │  Get mixin code │
//  │  Single parent only   │  Multiple OK         │  Multiple OK    │
//  │  Override selectively │  Override everything │  Use as-is      │
//  │  "IS-A" relationship  │  "CAN-DO" contract   │  "HAS ABILITY"  │
//  └───────────────────────┴──────────────────────┴─────────────────┘
//
//  ALL CLASS CONCEPTS COVERED:
//  ┌────────────────────────────┬────────────────────────────────────────────┐
//  │  Concept                   │  What it does                             │
//  ├────────────────────────────┼────────────────────────────────────────────┤
//  │  class                     │  Blueprint for creating objects            │
//  │  properties                │  Data stored inside an object              │
//  │  constructor               │  Initializes object on creation            │
//  │  this.property             │  Shorthand constructor assignment          │
//  │  methods                   │  Functions inside a class                  │
//  │  Named constructors        │  Alternative ways to create objects        │
//  │  Initializer list (:)      │  Set properties before constructor body    │
//  │  Private (_underscore)     │  Library-private, same file only           │
//  │  Getter (get)              │  Computed read access                      │
//  │  Setter (set)              │  Validated write access                    │
//  │  extends                   │  Inherit from parent class                 │
//  │  @override                 │  Replace parent method in child            │
//  │  super                     │  Pass data to parent constructor           │
//  │  Multi-level inheritance   │  Chain: A -> B -> C                        │
//  │  abstract class            │  Can't instantiate, defines a contract     │
//  │  implements                │  Must write all methods yourself           │
//  │  mixin / with              │  Share behavior across unrelated classes   │
//  │  static                    │  Class-level, accessed via ClassName       │
//  │  toString()                │  Custom string output for print()          │
//  └────────────────────────────┴────────────────────────────────────────────┘
//
//  QUICK DECISION RULES:
//  ┌──────────────────────────────────────────────────────────────┐
//  │  "Is B a kind of A?"                                        │
//  │     YES → use extends  (Truck extends Vehicle)              │
//  │                                                              │
//  │  "Must B fulfill a contract?"                                │
//  │     YES → use implements  (Report implements Printable)      │
//  │                                                              │
//  │  "Should B have an extra ability?"                           │
//  │     YES → use mixin with  (Duck with CanFly, CanSwim)       │
//  │                                                              │
//  │  "Should some data be hidden?"                               │
//  │     YES → use private _property + getters/setters            │
//  │                                                              │
//  │  "Should data belong to the class, not objects?"             │
//  │     YES → use static  (MathHelper.pi)                        │
//  └──────────────────────────────────────────────────────────────┘
//
//  This is the foundation for object-oriented programming in Dart.
//  These concepts are used everywhere in Flutter apps, server apps,
//  and any Dart project where you organize code into reusable pieces.
// =============================================================================
