//------------------------------------------------------------------------------
// C L A S S E S  —  S A M P L E  4
//------------------------------------------------------------------------------
//
// Multi-level Inheritance, Abstract Classes & Interfaces
//
// This file covers three advanced class concepts in Dart:
//   10. Multi-level inheritance (LivingThing/Animal/Dog)
//   11. Abstract classes (Appliance/WashingMachine/Microwave)
//   12. Interfaces with implements (Printable/Shareable/Report)
//
// -----------------------------------------------------------------------
//  #  | TOPIC                          | KEYWORDS USED            | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  10 | Multi-level inheritance        | extends chain            | Build a hierarchy of related classes
//  11 | Abstract classes               | abstract                 | Define a contract subclasses must follow
//  12 | Interfaces (implements)        | implements               | Force a class to implement all methods
// -----------------------------------------------------------------------
//
//------------------------------------------------------------------------------

void main() {
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
}

// ============================================================
//  CLASS DEFINITIONS
//  (Dart allows class definitions after main — the compiler
//   reads the entire file before running, so order doesn't matter)
// ============================================================

// ---- Section 10: Multi-level inheritance ----
// LivingThing is the top-level parent (grandparent).
// Animal extends LivingThing (parent) — inherits isAlive and status().
// Dog extends Animal (child) — inherits EVERYTHING from both levels.
// This creates a chain: LivingThing -> Animal -> Dog
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
// "abstract class" means you CANNOT do: var x = Appliance('Test');
// Abstract methods (turnOn, turnOff) have NO body — subclasses MUST implement them.
// Regular methods (applianceInfo) ARE inherited and work as-is.
// Think of abstract class as a contract: "You MUST have these methods."
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
// In Dart, any class can be used as an interface with "implements".
// Unlike "extends", "implements" does NOT inherit any code.
// The implementing class MUST write its own version of EVERY method.
// A class can implement MULTIPLE interfaces (unlike single extends).
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

// =============================================================================
//  NOTES: Sample 4 — Multi-level Inheritance, Abstract & Interfaces
// =============================================================================
//
//  CONCEPT               | WHAT IT DOES                          | EXAMPLE
// -----------------------|---------------------------------------|--------------------
//  Multi-level inherit.  | Chain: A -> B -> C, C gets everything | LivingThing->Animal->Dog
//  abstract class        | Can't instantiate, defines a contract | abstract class Appliance
//  abstract method       | No body, subclass MUST implement      | void turnOn();
//  regular method        | Inherited as-is by subclasses         | applianceInfo()
//  implements            | Must provide ALL methods yourself      | class Report implements ...
//  multiple interfaces   | Implement more than one at once       | implements Printable, Shareable
//
//  EXTENDS vs IMPLEMENTS:
//  ┌─────────────────────────────────────────────────────────┐
//  │  extends                    │  implements               │
//  ├─────────────────────────────┼───────────────────────────┤
//  │  Inherit parent's code      │  Must write ALL code      │
//  │  Override only what changes │  Override EVERYTHING      │
//  │  Single parent only         │  Multiple interfaces OK   │
//  │  "IS-A" relationship        │  "CAN-DO" contract        │
//  │  class Truck extends Vehicle│  class Report implements  │
//  │                             │    Printable, Shareable   │
//  └─────────────────────────────┴───────────────────────────┘
//
//  MULTI-LEVEL HIERARCHY:
//  ┌─────────────────────────────────────────┐
//  │  LivingThing  (isAlive, status())       │
//  │       ↓                                 │
//  │  Animal  (species, animalInfo())         │
//  │       ↓                                 │
//  │  Dog  (breed, dogInfo())                │
//  │  — Dog has access to ALL of the above   │
//  └─────────────────────────────────────────┘
//
//  KEY TAKEAWAYS:
//  - Multi-level inheritance builds a hierarchy where each level adds more
//  - Abstract classes define a "must-have" contract for subclasses
//  - "implements" forces you to write EVERYTHING yourself (no free code)
//  - Use "extends" for shared behavior, "implements" for contracts
//
// =============================================================================
