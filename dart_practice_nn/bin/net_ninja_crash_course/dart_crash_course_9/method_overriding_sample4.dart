//------------------------------------------------------------------------------
// M E T H O D - O V E R R I D I N G
//------------------------------------------------------------------------------
// SAMPLE 4: OVERRIDING toString() — Custom Print Output
//------------------------------------------------------------------------------
//
// Every Dart object inherits toString() from the Object class.
// By default, print(myObject) shows "Instance of 'ClassName'"
// which is not helpful. Override toString() to show useful info.
//
// toString() is called automatically by:
//   - print(object)
//   - string interpolation: "$object" or "${object}"
//   - string concatenation: "text " + object.toString()
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                              | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Print an object WITHOUT toString()        | Shows unhelpful default output
//  2  | Print an object WITH toString() override  | Shows useful, readable info
//  3  | toString() works in string interpolation  | Automatic conversion to string
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. CREATE AN OBJECT WITHOUT toString() OVERRIDE
  //    NoToString doesn't override toString(), so Dart uses
  //    the default from Object: "Instance of 'NoToString'"
  //    This is NOT helpful for debugging or displaying data.
  // ============================================================
  var defaultObj = NoToString();
  print(defaultObj); // Instance of 'NoToString'  (not useful!)

  // ============================================================
  // 2. CREATE AN OBJECT WITH toString() OVERRIDE
  //    Coordinate overrides toString() to show its lat/lng values.
  //    Now print(coord) shows meaningful information.
  // ============================================================
  var coord = Coordinate(42.3, -71.1);
  print(coord); // Coordinate(42.3, -71.1)  (much better!)

  // ============================================================
  // 3. toString() IN STRING INTERPOLATION
  //    When you use $object or ${object} inside a string, Dart
  //    automatically calls object.toString(). So your override
  //    works everywhere strings are built.
  // ============================================================
  print('Location: $coord'); // Location: Coordinate(42.3, -71.1)

  // ============================================================
  //  KEY TAKEAWAY:
  //  toString() is the most commonly overridden method in Dart.
  //  Override it to make your objects print useful information
  //  instead of the default "Instance of 'ClassName'" message.
  //
  //  Every class you create should probably override toString()
  //  if you ever plan to print it or use it in debug messages.
  // ============================================================
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// ---- Class without toString() override ----
// Uses the default toString() from Object.
// print(NoToString()) → "Instance of 'NoToString'" (not useful)
class NoToString {
  // No toString() override — prints "Instance of 'NoToString'"
}

// ---- Class with toString() override ----
// Overrides toString() to show the coordinate values.
// print(Coordinate(42.3, -71.1)) → "Coordinate(42.3, -71.1)" (useful!)
class Coordinate {
  double lat;
  double lng;

  Coordinate(this.lat, this.lng);

  // Override toString() to return a readable representation.
  // This is called automatically by print(), "$object", etc.
  @override
  String toString() {
    return 'Coordinate($lat, $lng)';
  }
}

// ============================================================
// NOTES: Overriding toString() — Summary
// ============================================================
//  1. Every Dart object has toString() inherited from Object
//  2. Default: "Instance of 'ClassName'" — not helpful
//  3. Override it to return a readable string representation
//  4. toString() is called automatically by:
//     - print(object)
//     - "$object" or "${object}" in string interpolation
//     - object.toString() explicitly
//  5. toString() is the MOST commonly overridden method in Dart
//
//  COMMON toString() PATTERNS:
//  ┌──────────────────────────────────────────────────────────┐
//  │  // Pattern A: Constructor-like format                   │
//  │  @override                                               │
//  │  String toString() => 'ClassName(field1, field2)';       │
//  │                                                          │
//  │  // Pattern B: Key-value format                          │
//  │  @override                                               │
//  │  String toString() => 'ClassName{x: $x, y: $y}';        │
//  │                                                          │
//  │  // Pattern C: Human-readable format                     │
//  │  @override                                               │
//  │  String toString() => '$name ($age years old)';          │
//  └──────────────────────────────────────────────────────────┘
//
//  OTHER COMMON METHODS TO OVERRIDE (from Object):
//  - ==  (operator)  → custom equality check
//  - hashCode        → must match == logic
//  - toString()      → custom print output (this sample)
// ============================================================
