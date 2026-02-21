//------------------------------------------------------------------------------
// M E T H O D - O V E R R I D I N G  —  C O M P L E T E  G U I D E
//------------------------------------------------------------------------------
//
// This file combines ALL 6 samples into one runnable file.
// Method overriding lets a child class REPLACE a method it inherited
// from a parent class with its own version. The method keeps the same
// name and parameters, but the behavior changes.
//
// Think of it like this: a parent class says "here's how to do X",
// and the child class says "no thanks, I'll do X my own way."
//
// Each section has a numbered header, a short description of what it does,
// and a line explaining when/why to use it.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                                  | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Basic method override                  | Replace inherited behavior entirely
//  2  | @override annotation                   | Signal intent and catch typos
//  3  | Calling super inside an override        | Extend parent behavior instead of replacing it
//  4  | Overriding toString()                  | Custom output when printing objects
//  5  | Multi-level override                   | Override through a chain of classes
//  6  | Real-world example: Menu items          | Combine all override concepts together
// -----------------------------------------------------------------------
//
// TIP: To run just ONE sample, comment out the others in main().
//
// NOTE: Class names are prefixed (S1, S2, etc.) to avoid naming collisions
// since all samples are combined in one file.
//
// -----------------------------------------------------------------------

void main() {
  // ============================================================
  //  Uncomment/comment any sample to run only what you want.
  //  Each sample is independent — they don't depend on each other.
  // ============================================================

  sample1Basic();
  sample2Annotation();
  sample3Super();
  sample4ToString();
  sample5MultiLevel();
  sample6RealWorld();
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  1:  BASIC METHOD OVERRIDE — Replace Inherited Behavior
//
//  When a child class has the SAME method name as its parent,
//  the child's version wins. The parent's version is ignored
//  unless you explicitly call it with "super".
//
//  Use this when the parent's behavior doesn't fit the child.
//
//  Parent says: "All animals make a sound."
//  Cat says:    "Actually, I say Meow!"
//
// =============================================================================
// =============================================================================

void sample1Basic() {
  print('');
  print('##############################################');
  print('# SAMPLE 1: Basic Method Override             #');
  print('##############################################');

  // Create parent and child instances
  var anyAnimal = S1Animal('some animal');
  var cat = S1Cat('Whiskers');

  // Call speak() on both — Cat's overridden version wins
  print('  ${anyAnimal.speak()}'); // some animal makes a sound
  print('  ${cat.speak()}'); // Whiskers says: Meow!  (overridden)

  print('');
}

// --- Sample 1: Class definitions ---

class S1Animal {
  String name;

  S1Animal(this.name);

  // Default behavior — every animal "makes a sound"
  String speak() {
    return '$name makes a sound';
  }
}

class S1Cat extends S1Animal {
  S1Cat(super.name);

  // Override: Cat replaces Animal's speak() with its own version
  @override
  String speak() {
    return '$name says: Meow!';
  }
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  2:  @override ANNOTATION — Signal Intent and Catch Mistakes
//
//  Adding @override is optional but STRONGLY recommended.
//  It tells Dart: "I intend to replace a parent method."
//  If you misspell the method name, Dart will warn you
//  instead of silently creating a brand-new method.
//
//  Without @override:
//    String spaek() { ... }  // typo! Creates a NEW method
//  With @override:
//    @override
//    String spaek() { ... }  // ERROR! Dart catches the typo!
//
// =============================================================================
// =============================================================================

void sample2Annotation() {
  print('##############################################');
  print('# SAMPLE 2: @override Annotation              #');
  print('##############################################');

  var basicCalc = S2Calculator();
  var sciCalc = S2ScientificCalculator();

  // description() — overridden in ScientificCalculator
  print('  ${basicCalc.description()}'); // Basic calculator
  print('  ${sciCalc.description()}'); // Scientific calculator with advanced functions

  // add() — inherited, NOT overridden (same result for both)
  print('  ${basicCalc.add(3, 5)}'); // 8.0
  print('  ${sciCalc.add(3, 5)}'); // 8.0  (inherited, not overridden)

  // power() — new method, only in ScientificCalculator
  print('  ${sciCalc.power(2, 10)}'); // 1024.0  (new method, only in child)

  print('');
}

// --- Sample 2: Class definitions ---

class S2Calculator {
  double add(double a, double b) {
    return a + b;
  }

  String description() {
    return 'Basic calculator';
  }
}

class S2ScientificCalculator extends S2Calculator {
  // @override signals: "I'm intentionally replacing description()"
  @override
  String description() {
    return 'Scientific calculator with advanced functions';
  }

  // New method — NOT an override, just an addition
  double power(double base, double exponent) {
    double result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  3:  CALLING SUPER INSIDE AN OVERRIDE — Extend, Don't Replace
//
//  Sometimes you don't want to throw away the parent's work.
//  Use "super.methodName()" inside your override to run the
//  parent's version FIRST, then add your own logic on top.
//
//  Think of it as: "Do everything the parent does, PLUS more."
//
// =============================================================================
// =============================================================================

void sample3Super() {
  print('##############################################');
  print('# SAMPLE 3: Calling Super Inside Override     #');
  print('##############################################');

  var basicLogger = S3Logger();
  var timestampLogger = S3TimestampLogger();

  // basicLogger.log() → just the [LOG] prefix
  print('  Basic logger:');
  basicLogger.log('Server started');
  // [LOG] Server started

  // timestampLogger.log() → [LOG] prefix + timestamp (via super)
  print('  Timestamp logger:');
  timestampLogger.log('Server started');
  // [LOG] Server started | Logged at: <timestamp>

  print('');
}

// --- Sample 3: Class definitions ---

class S3Logger {
  void log(String message) {
    print('  [LOG] $message');
  }
}

class S3TimestampLogger extends S3Logger {
  @override
  void log(String message) {
    // Call parent's log() with enhanced message (super.log)
    var timestamp = DateTime.now().toIso8601String();
    super.log('$message | Logged at: $timestamp');
  }
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  4:  OVERRIDING toString() — Custom Print Output
//
//  Every Dart object inherits toString() from the Object class.
//  By default, print(myObject) shows "Instance of 'ClassName'"
//  which is not helpful. Override toString() to show useful info.
//
//  toString() is called automatically by:
//    - print(object)
//    - string interpolation: "$object" or "${object}"
//    - string concatenation: "text " + object.toString()
//
// =============================================================================
// =============================================================================

void sample4ToString() {
  print('##############################################');
  print('# SAMPLE 4: Overriding toString()             #');
  print('##############################################');

  // Without toString() override — unhelpful default output
  var defaultObj = S4NoToString();
  print('  $defaultObj'); // Instance of 'S4NoToString'  (not useful!)

  // With toString() override — meaningful output
  var coord = S4Coordinate(42.3, -71.1);
  print('  $coord'); // Coordinate(42.3, -71.1)  (much better!)

  // toString() works automatically in string interpolation
  print('  Location: $coord'); // Location: Coordinate(42.3, -71.1)

  print('');
}

// --- Sample 4: Class definitions ---

class S4NoToString {
  // No toString() override — prints "Instance of 'S4NoToString'"
}

class S4Coordinate {
  double lat;
  double lng;

  S4Coordinate(this.lat, this.lng);

  @override
  String toString() {
    return 'Coordinate($lat, $lng)';
  }
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  5:  MULTI-LEVEL OVERRIDE — Override Through a Chain
//
//  When you have A -> B -> C (grandparent -> parent -> child),
//  each level can override the same method. The most specific
//  (deepest child) version wins. Each level can call super
//  to reach the version one level above it.
//
//  Employee → Manager → Director
//  Each overrides role() with its own version.
//
// =============================================================================
// =============================================================================

void sample5MultiLevel() {
  print('##############################################');
  print('# SAMPLE 5: Multi-Level Override              #');
  print('##############################################');

  var employee = S5Employee('Bob');
  var manager = S5Manager('Alice');
  var director = S5Director('Carol');

  // Each calls its OWN version of role()
  print('  ${employee.role()}'); // Bob is an Employee
  print('  ${manager.role()}'); // Bob's manager: Alice is a Manager
  print('  ${director.role()}'); // Alice's director: Carol is a Director (top priority)

  print('');
}

// --- Sample 5: Class definitions ---

class S5Employee {
  String name;

  S5Employee(this.name);

  String role() {
    return '$name is an Employee';
  }
}

class S5Manager extends S5Employee {
  S5Manager(super.name);

  @override
  String role() {
    return "Bob's manager: $name is a Manager";
  }
}

class S5Director extends S5Manager {
  S5Director(super.name);

  @override
  String role() {
    return "Alice's director: $name is a Director (top priority)";
  }
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  6:  REAL-WORLD EXAMPLE — Menu Items
//
//  This combines multiple override concepts:
//    - Basic override: Pizza replaces format() with its own
//    - toString() override: MenuItem uses format() inside toString()
//    - Polymorphism: print() calls the correct format() for each type
//
//  When you call print(pizza), Dart calls:
//    pizza.toString() -> pizza.format() (the overridden version)
//
// =============================================================================
// =============================================================================

void sample6RealWorld() {
  print('##############################################');
  print('# SAMPLE 6: Real-World Menu Example           #');
  print('##############################################');

  var noodle = S6MenuItem('Veg Noodles', 9.99);
  var pizza = S6Pizza(['peppers', 'mushrooms', 'olives'], 'Veg Pizza', 15.99);
  var burger = S6Burger('Classic Burger', 12.49, true);

  // Each prints differently because format() is overridden
  print('  $noodle');
  // Veg Noodles --> $9.99

  print('  $pizza');
  // PIZZA: Veg Pizza
  //  PRICE: $15.99
  //  TOPPINGS: peppers, mushrooms, olives

  print('  $burger');
  // BURGER: Classic Burger
  //  PRICE: $12.49
  //  Combo: Yes

  // Polymorphism in action: a list of MenuItems, each prints differently
  var menu = <S6MenuItem>[noodle, pizza, burger];
  print('');
  print('  --- Full Menu ---');
  for (var item in menu) {
    print('  $item'); // calls the correct overridden format() for each type
    print('  ---');
  }

  print('');
}

// --- Sample 6: Class definitions ---

class S6MenuItem {
  String title;
  double price;

  S6MenuItem(this.title, this.price);

  String format() {
    return '$title --> \$$price';
  }

  @override
  String toString() {
    return format();
  }
}

class S6Pizza extends S6MenuItem {
  List<String> toppings;

  S6Pizza(this.toppings, super.title, super.price);

  @override
  String format() {
    var formattedToppings = toppings.join(', ');
    return 'PIZZA: $title\n PRICE: \$$price\n TOPPINGS: $formattedToppings';
  }
}

class S6Burger extends S6MenuItem {
  bool isCombo;

  S6Burger(super.title, super.price, this.isCombo);

  @override
  String format() {
    return 'BURGER: $title\n PRICE: \$$price\n Combo: ${isCombo ? "Yes" : "No"}';
  }
}

// =============================================================================
// =============================================================================
//  NOTES: Method Overriding — Complete Summary of ALL 6 Samples
// =============================================================================
//
//  WHAT IS METHOD OVERRIDING?
//  --------------------------
//  When a child class defines a method with the SAME name as one in its parent,
//  the child's version replaces the parent's. This is "overriding."
//
//  KEY RULES:
//  ----------
//  1. The method name and parameters must match the parent's method exactly.
//  2. Use @override annotation — it's optional but prevents bugs from typos.
//  3. Use super.method() to call the parent's version from inside the override.
//  4. The most specific (deepest child) version always wins.
//
//  -----------------------------------------------------------------------
//   #  | TOPIC                          | WHAT IT TEACHES
//  ----|--------------------------------|-------------------------------------------
//   1  | Basic method override          | Cat overrides Animal.speak() entirely
//   2  | @override annotation           | Catches typos, signals intent to readers
//   3  | Calling super in override      | TimestampLogger extends Logger.log()
//   4  | Overriding toString()          | Coordinate shows useful info when printed
//   5  | Multi-level override           | Employee -> Manager -> Director chain
//   6  | Real-world menu example        | Pizza & Burger override MenuItem.format()
//  ----|--------------------------------|-------------------------------------------
//
//  OVERRIDE vs. NEW METHOD:
//  ------------------------
//  - Override:    Same name as parent method  → replaces parent behavior
//  - New method:  Different name              → adds new behavior alongside inherited ones
//
//  COMMON METHODS TO OVERRIDE:
//  ---------------------------
//  - toString()       → custom print output (inherited from Object)
//  - ==  (operator)   → custom equality check
//  - hashCode         → must match == logic
//  - compareTo()      → custom sorting (when implementing Comparable)
//
//  REMEMBER:
//  - @override does NOT change behavior — it's a safety annotation
//  - super.method() calls the PARENT's version, not the grandparent's
//  - If you don't override, the parent's method is inherited as-is
//  - toString() is the most commonly overridden method in Dart
//
// =============================================================================
