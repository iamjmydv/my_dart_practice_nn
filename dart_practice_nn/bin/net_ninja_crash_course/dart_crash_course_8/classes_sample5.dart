//------------------------------------------------------------------------------
// C L A S S E S  —  S A M P L E  5
//------------------------------------------------------------------------------
//
// Mixins, Static Properties/Methods & toString() Override
//
// This file covers the final three class concepts in Dart:
//   13. Mixins with mixin/with (CanFly/CanSwim/Duck/Superhero)
//   14. Static properties and methods (MathHelper)
//   15. toString() override (Product)
//
// -----------------------------------------------------------------------
//  #  | TOPIC                          | KEYWORDS USED            | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  13 | Mixins                         | mixin, with              | Share behavior across unrelated classes
//  14 | Static properties and methods  | static                   | Class-level data shared by all instances
//  15 | toString() override            | @override toString()     | Custom string representation of objects
// -----------------------------------------------------------------------
//
//------------------------------------------------------------------------------

void main() {
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
}

// ============================================================
//  CLASS DEFINITIONS
//  (Dart allows class definitions after main — the compiler
//   reads the entire file before running, so order doesn't matter)
// ============================================================

// ---- Section 13: Mixins ----
// A mixin is like a "bag of methods" you can attach to any class.
// Unlike extends (single parent), a class can use MULTIPLE mixins.
// Use "mixin" to define, "with" to apply.
// Duck uses CanFly + CanSwim. Superhero uses CanFly + CanSwim + CanRun.
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
// "static" means the member belongs to the CLASS, not to any object.
// You access it with: MathHelper.pi, MathHelper.circleArea(5)
// You do NOT need to create an object to use static members.
// Static is great for constants (pi), counters (instanceCount),
// and utility/helper methods that don't need instance data.
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
// Every Dart object has a toString() method inherited from Object.
// By default it returns "Instance of 'ClassName'" which is not useful.
// Override it to return a meaningful string representation.
// print(object) and "$object" both call toString() automatically.
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
//  NOTES: Sample 5 — Mixins, Static & toString
// =============================================================================
//
//  CONCEPT               | WHAT IT DOES                          | EXAMPLE
// -----------------------|---------------------------------------|--------------------
//  mixin                 | Defines reusable behavior             | mixin CanFly { ... }
//  with                  | Applies mixin(s) to a class           | class Duck with CanFly, CanSwim
//  static property       | Belongs to the class, not instances   | static const double pi
//  static method         | Called on the class, not an object    | MathHelper.circleArea(5)
//  static counter        | Shared across all instances           | static int instanceCount
//  toString() override   | Custom print output for objects       | @override String toString()
//
//  MIXIN vs EXTENDS vs IMPLEMENTS:
//  ┌─────────────────────────────────────────────────────────────┐
//  │  extends       │  implements       │  with (mixin)          │
//  ├────────────────┼───────────────────┼────────────────────────┤
//  │  Inherit code  │  Write all code   │  Get mixin's code      │
//  │  Single parent │  Multiple OK      │  Multiple OK           │
//  │  "IS-A"        │  "CAN-DO"         │  "HAS ABILITY"         │
//  │  Truck is a    │  Report can be    │  Duck has ability       │
//  │  Vehicle       │  Printed/Shared   │  to Fly and Swim       │
//  └────────────────┴───────────────────┴────────────────────────┘
//
//  STATIC vs INSTANCE:
//  ┌─────────────────────────────────────────────────────────────┐
//  │  Static                        │  Instance                  │
//  ├────────────────────────────────┼────────────────────────────┤
//  │  Belongs to the CLASS          │  Belongs to each OBJECT    │
//  │  MathHelper.pi                 │  helperOne.runtimeType     │
//  │  Shared across all instances   │  Unique to each instance   │
//  │  No "this" access              │  Has "this" access         │
//  │  Good for constants, utilities │  Good for object-specific  │
//  └────────────────────────────────┴────────────────────────────┘
//
//  KEY TAKEAWAYS:
//  - Mixins add capabilities without inheritance — perfect for shared abilities
//  - Static members are class-level — no object needed to access them
//  - toString() makes objects print-friendly — called by print() and $interpolation
//  - Mixins solve the "diamond problem" — a class can have multiple mixins
//
// =============================================================================
