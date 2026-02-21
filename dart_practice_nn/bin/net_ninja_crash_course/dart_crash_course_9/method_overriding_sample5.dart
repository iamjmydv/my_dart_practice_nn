//------------------------------------------------------------------------------
// M E T H O D - O V E R R I D I N G
//------------------------------------------------------------------------------
// SAMPLE 5: MULTI-LEVEL OVERRIDE — Override Through a Chain of Classes
//------------------------------------------------------------------------------
//
// When you have A -> B -> C (grandparent -> parent -> child),
// each level can override the same method. The most specific
// (deepest child) version wins. Each level can call super
// to reach the version one level above it.
//
// Grandparent: "I greet casually"
// Parent:      "I greet formally"     (overrides grandparent)
// Child:       "I greet extra formally" (overrides parent)
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                              | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Employee defines role()                   | Base-level role description
//  2  | Manager overrides role()                  | Manager-specific behavior
//  3  | Director overrides role() again           | Director-specific behavior (deepest wins)
//  4  | Call role() on all three                  | See which version runs for each type
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. CREATE INSTANCES AT EACH LEVEL
  //    Employee → base class (grandparent in the chain)
  //    Manager  → extends Employee (parent in the chain)
  //    Director → extends Manager (child — deepest level)
  // ============================================================
  var employee = Employee('Bob');
  var manager = Manager('Alice');
  var director = Director('Carol');

  // ============================================================
  // 2. CALL role() ON EACH — The deepest override wins
  //    - employee.role() → Employee's version (no override above)
  //    - manager.role()  → Manager's OVERRIDDEN version
  //    - director.role() → Director's OVERRIDDEN version (deepest)
  //
  //    Each class defines its own role() that replaces the one
  //    it inherited from its parent.
  // ============================================================
  print(employee.role()); // Bob is an Employee
  print(manager.role()); // Bob's manager: Alice is a Manager
  print(director.role()); // Alice's director: Carol is a Director (top priority)

  // ============================================================
  //  KEY TAKEAWAY:
  //  In a multi-level inheritance chain (A -> B -> C), each level
  //  can override the same method. Dart always runs the version
  //  from the ACTUAL type of the object, not the declared type.
  //
  //  If Director overrides role(), calling role() on a Director
  //  object ALWAYS runs Director's version — even if the variable
  //  is declared as Employee.
  //
  //  IMPORTANT:
  //  - super.role() in Director calls Manager's version (one level up)
  //  - super.role() in Manager calls Employee's version (one level up)
  //  - super only goes ONE level up, not to the top
  // ============================================================
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// ---- Base class: Employee (grandparent in the chain) ----
// Defines the original role() method.
class Employee {
  String name;

  Employee(this.name);

  String role() {
    return '$name is an Employee';
  }
}

// ---- Middle class: Manager (extends Employee) ----
// Overrides role() with its own version.
// Manager.role() replaces Employee.role().
class Manager extends Employee {
  Manager(super.name);

  @override
  String role() {
    return "Bob's manager: $name is a Manager";
  }
}

// ---- Deepest class: Director (extends Manager) ----
// Overrides role() again. This is the deepest level.
// Director.role() replaces Manager.role().
// Director's version always wins for Director objects.
class Director extends Manager {
  Director(super.name);

  @override
  String role() {
    return "Alice's director: $name is a Director (top priority)";
  }
}

// ============================================================
// NOTES: Multi-Level Override — Summary
// ============================================================
//  1. Each level in the inheritance chain can override the same method
//  2. The DEEPEST (most specific) version always wins
//  3. super.method() calls the version ONE level above, not the top
//  4. The actual TYPE of the object determines which version runs
//
//  INHERITANCE CHAIN:
//  ┌──────────────────────────────────────────────────────────┐
//  │  Employee           ← base (defines role())             │
//  │    └── Manager      ← overrides role() from Employee    │
//  │         └── Director ← overrides role() from Manager    │
//  └──────────────────────────────────────────────────────────┘
//
//  SUPER CALLS IN A CHAIN:
//  ┌──────────────────────────────────────────────────────────┐
//  │  Director.role()                                         │
//  │    └── super.role()  → calls Manager.role()              │
//  │                                                          │
//  │  Manager.role()                                          │
//  │    └── super.role()  → calls Employee.role()             │
//  │                                                          │
//  │  Employee.role()                                         │
//  │    └── (no super — this is the base)                     │
//  └──────────────────────────────────────────────────────────┘
//
//  POLYMORPHISM:
//  Even if you store a Director in an Employee variable:
//    Employee e = Director('Carol');
//    e.role();  → runs Director's version (the actual type wins!)
// ============================================================
