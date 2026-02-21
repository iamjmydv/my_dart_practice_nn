//------------------------------------------------------------------------------
// C L A S S E S  —  S A M P L E  2
//------------------------------------------------------------------------------
//
// Named Constructors, Private Properties & Getters/Setters
//
// This file covers three intermediate class concepts in Dart:
//   4. Named constructors (Point)
//   5. Private properties (BankAccount)
//   6. Getters and Setters (Rectangle)
//
// -----------------------------------------------------------------------
//  #  | TOPIC                          | KEYWORDS USED            | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  4  | Named constructors             | ClassName.name()         | Multiple ways to create the same object
//  5  | Private properties             | _underscore              | Hide internal data from outside access
//  6  | Getters and Setters            | get, set                 | Control how properties are read and written
// -----------------------------------------------------------------------
//
//------------------------------------------------------------------------------

void main() {
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
}

// ============================================================
//  CLASS DEFINITIONS
//  (Dart allows class definitions after main — the compiler
//   reads the entire file before running, so order doesn't matter)
// ============================================================

// ---- Section 4: Named constructors ----
// Named constructors provide alternative ways to create an object.
// The initializer list (: x = value, y = value) runs BEFORE the
// constructor body and sets properties directly.
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
// Adding _ before a property name makes it "library-private".
// This means it can only be accessed within the same file.
// External code must use methods like deposit(), withdraw(),
// and checkBalance() to interact with the balance.
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
// Getters compute values on the fly without storing them.
// Setters add validation logic before assigning a value.
// The private _width and _height are the "backing fields" —
// the actual data that getters read and setters write to.
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

// =============================================================================
//  NOTES: Sample 2 — Named Constructors, Private Properties & Getters/Setters
// =============================================================================
//
//  CONCEPT               | WHAT IT DOES                          | EXAMPLE
// -----------------------|---------------------------------------|--------------------
//  Named constructor     | Alternative way to create an object   | Point.origin()
//  Initializer list      | Set properties before body runs       | : x = 0, y = 0
//  Private property (_)  | Library-private, same file only       | double _balance;
//  Getter (get)          | Computed read-only property           | double get area => ...
//  Setter (set)          | Validated write access                | set width(double v) { ... }
//  Backing field         | Private variable behind getter/setter | double _width;
//
//  KEY TAKEAWAYS:
//  - Named constructors let you create objects from different data shapes
//  - Private properties protect data — control access through methods
//  - Getters compute values without storing extra data
//  - Setters validate input before allowing changes
//  - The underscore (_) is Dart's way of saying "hands off" to other files
//
// =============================================================================
