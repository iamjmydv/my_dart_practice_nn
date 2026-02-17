//---------------------------------------------
// M E T H O D - O V E R R I D I N G
//---------------------------------------------
//
// Method overriding lets a child class REPLACE a method it inherited
// from a parent class with its own version. The method keeps the same
// name and parameters, but the behavior changes.
//
// Think of it like this: a parent class says "here's how to do X",
// and the child class says "no thanks, I'll do X my own way."
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
void main() {
  // ============================================================
  // 1. BASIC METHOD OVERRIDE - Replace inherited behavior
  //    When a child class has the SAME method name as its parent,
  //    the child's version wins. The parent's version is ignored
  //    unless you explicitly call it with "super".
  //
  //    Use this when the parent's behavior doesn't fit the child.
  // ============================================================
  var anyAnimal = Animal('some animal');
  var cat = Cat('Whiskers');

  print(anyAnimal.speak()); // some animal makes a sound
  print(cat.speak()); // Whiskers says: Meow!  (overridden)

  // ============================================================
  // 2. @override ANNOTATION - Signal intent and catch mistakes
  //    Adding @override is optional but STRONGLY recommended.
  //    It tells Dart: "I intend to replace a parent method."
  //    If you misspell the method name, Dart will warn you
  //    instead of silently creating a brand-new method.
  //
  //    Without @override:
  //      String spaek() { ... }  // typo! This creates a NEW method
  //                               // and the parent's speak() still runs
  //    With @override:
  //      @override
  //      String spaek() { ... }  // ERROR! Dart says "spaek" doesn't
  //                               // exist in the parent. Typo caught!
  // ============================================================
  var basicCalc = Calculator();
  var sciCalc = ScientificCalculator();

  print(basicCalc.description()); // Basic calculator
  print(sciCalc.description()); // Scientific calculator with advanced functions

  // Both have add(), but ScientificCalculator also has power()
  print(basicCalc.add(3, 5)); // 8
  print(sciCalc.add(3, 5)); // 8  (inherited, not overridden)
  print(sciCalc.power(2, 10)); // 1024.0  (new method, only in child)

  // ============================================================
  // 3. CALLING SUPER INSIDE AN OVERRIDE - Extend, don't replace
  //    Sometimes you don't want to throw away the parent's work.
  //    Use "super.methodName()" inside your override to run the
  //    parent's version FIRST, then add your own logic on top.
  //
  //    Think of it as: "Do everything the parent does, PLUS more."
  // ============================================================
  var basicLogger = Logger();
  var timestampLogger = TimestampLogger();

  basicLogger.log('Server started'); // [LOG] Server started
  timestampLogger.log('Server started'); // [LOG] Server started | Logged at: <timestamp>

  // ============================================================
  // 4. OVERRIDING toString() - Custom print output
  //    Every Dart object inherits toString() from the Object class.
  //    By default, print(myObject) shows "Instance of 'ClassName'"
  //    which is not helpful. Override toString() to show useful info.
  //
  //    toString() is called automatically by:
  //      - print(object)
  //      - string interpolation: "$object" or "${object}"
  //      - string concatenation: "text " + object.toString()
  // ============================================================
  var coord = Coordinate(42.3, -71.1);
  var defaultObj = NoToString();

  print(defaultObj); // Instance of 'NoToString'  (not useful!)
  print(coord); // Coordinate(42.3, -71.1)  (much better)
  print('Location: $coord'); // Location: Coordinate(42.3, -71.1)

  // ============================================================
  // 5. MULTI-LEVEL OVERRIDE - Override through a chain
  //    When you have A -> B -> C (grandparent -> parent -> child),
  //    each level can override the same method. The most specific
  //    (deepest child) version wins. Each level can call super
  //    to reach the version one level above it.
  //
  //    Grandparent: "I greet casually"
  //    Parent:      "I greet formally"     (overrides grandparent)
  //    Child:       "I greet extra formally" (overrides parent)
  // ============================================================
  var employee = Employee('Bob');
  var manager = Manager('Alice');
  var director = Director('Carol');

  print(employee.role()); // Bob is an Employee
  print(manager.role()); // Bob's manager: Alice is a Manager
  print(director.role()); // Alice's director: Carol is a Director (top priority)

  // ============================================================
  // 6. REAL-WORLD EXAMPLE: Menu Items
  //    This combines multiple override concepts:
  //    - Basic override: Pizza replaces format() with its own
  //    - toString() override: MenuItem uses format() inside toString()
  //    - Polymorphism: print() calls the correct format() for each type
  //
  //    When you call print(pizza), Dart calls:
  //      pizza.toString() -> pizza.format() (the overridden version)
  // ============================================================
  var noodle = MenuItem('Veg Noodles', 9.99);
  var pizza = Pizza(['peppers', 'mushrooms', 'olives'], 'Veg Pizza', 15.99);
  var burger = Burger('Classic Burger', 12.49, true);

  print(noodle);
  // Veg Noodles --> $9.99

  print(pizza);
  // PIZZA: Veg Pizza
  //  PRICE: $15.99
  //  TOPPINGS: peppers, mushrooms, olives

  print(burger);
  // BURGER: Classic Burger
  //  PRICE: $12.49
  //  Combo: Yes

  // Polymorphism in action: a list of MenuItems, each prints differently
  var menu = <MenuItem>[noodle, pizza, burger];
  print('\n--- Full Menu ---');
  for (var item in menu) {
    print(item); // calls the correct overridden format() for each type
    print('---');
  }
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// ---- Section 1: Basic method override ----
class Animal {
  String name;

  Animal(this.name);

  String speak() {
    return '$name makes a sound';
  }
}

class Cat extends Animal {
  Cat(super.name);

  @override
  String speak() {
    return '$name says: Meow!';
  }
}

// ---- Section 2: @override annotation ----
class Calculator {
  double add(double a, double b) {
    return a + b;
  }

  String description() {
    return 'Basic calculator';
  }
}

class ScientificCalculator extends Calculator {
  @override
  String description() {
    return 'Scientific calculator with advanced functions';
  }

  // New method — not an override, just an addition
  double power(double base, double exponent) {
    double result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }
}

// ---- Section 3: Calling super inside an override ----
class Logger {
  void log(String message) {
    print('[LOG] $message');
  }
}

class TimestampLogger extends Logger {
  @override
  void log(String message) {
    // Call the parent's log() first, then add extra info
    var timestamp = DateTime.now().toIso8601String();
    super.log('$message | Logged at: $timestamp');
  }
}

// ---- Section 4: Overriding toString() ----
class NoToString {
  // No toString() override — prints "Instance of 'NoToString'"
}

class Coordinate {
  double lat;
  double lng;

  Coordinate(this.lat, this.lng);

  @override
  String toString() {
    return 'Coordinate($lat, $lng)';
  }
}

// ---- Section 5: Multi-level override ----
class Employee {
  String name;

  Employee(this.name);

  String role() {
    return '$name is an Employee';
  }
}

class Manager extends Employee {
  Manager(super.name);

  @override
  String role() {
    return "Bob's manager: $name is a Manager";
  }
}

class Director extends Manager {
  Director(super.name);

  @override
  String role() {
    return "Alice's director: $name is a Director (top priority)";
  }
}

// ---- Section 6: Real-world menu example ----
class MenuItem {
  String title;
  double price;

  MenuItem(this.title, this.price);

  String format() {
    return '$title --> \$$price';
  }

  @override
  String toString() {
    return format();
  }
}

class Pizza extends MenuItem {
  List<String> toppings;

  Pizza(this.toppings, super.title, super.price);

  @override
  String format() {
    var formattedToppings = toppings.join(', ');
    return 'PIZZA: $title\n PRICE: \$$price\n TOPPINGS: $formattedToppings';
  }
}

class Burger extends MenuItem {
  bool isCombo;

  Burger(super.title, super.price, this.isCombo);

  @override
  String format() {
    return 'BURGER: $title\n PRICE: \$$price\n Combo: ${isCombo ? "Yes" : "No"}';
  }
}

// =============================================================================
//  NOTES: Method Overriding — Complete Summary
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
//  #  | TOPIC                          | WHAT IT TEACHES
// ----|--------------------------------|-------------------------------------------
//  1  | Basic method override          | Cat overrides Animal.speak() entirely
//  2  | @override annotation           | Catches typos, signals intent to readers
//  3  | Calling super in override      | TimestampLogger extends Logger.log()
//  4  | Overriding toString()          | Coordinate shows useful info when printed
//  5  | Multi-level override           | Employee -> Manager -> Director chain
//  6  | Real-world menu example        | Pizza & Burger override MenuItem.format()
// ----|--------------------------------|-------------------------------------------
//
//  REMEMBER:
//  - @override does NOT change behavior — it's a safety annotation
//  - super.method() calls the PARENT's version, not the grandparent's
//  - If you don't override, the parent's method is inherited as-is
//  - toString() is the most commonly overridden method in Dart
//
// =============================================================================
