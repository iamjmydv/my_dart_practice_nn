//------------------------------------------------------------------------------
// M E T H O D - O V E R R I D I N G
//------------------------------------------------------------------------------
// SAMPLE 2: @override ANNOTATION — Signal Intent and Catch Mistakes
//------------------------------------------------------------------------------
//
// Adding @override is optional but STRONGLY recommended.
// It tells Dart: "I intend to replace a parent method."
// If you misspell the method name, Dart will warn you
// instead of silently creating a brand-new method.
//
// Without @override:
//   String spaek() { ... }  // typo! This creates a NEW method
//                            // and the parent's speak() still runs
// With @override:
//   @override
//   String spaek() { ... }  // ERROR! Dart says "spaek" doesn't
//                            // exist in the parent. Typo caught!
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                                  | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Parent Calculator has description() and add() | Base functionality
//  2  | Child overrides description() with @override  | Shows intent clearly
//  3  | Child inherits add() without overriding it    | Inherited methods work as-is
//  4  | Child adds a NEW method: power()              | New methods are additions, not overrides
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. CREATE A BASIC CALCULATOR (parent class)
  //    Has two methods: description() and add()
  // ============================================================
  var basicCalc = Calculator();

  // ============================================================
  // 2. CREATE A SCIENTIFIC CALCULATOR (child class)
  //    - Overrides description() to return its own message
  //    - Inherits add() from Calculator (does NOT override it)
  //    - Adds a NEW method power() that only it has
  // ============================================================
  var sciCalc = ScientificCalculator();

  // ============================================================
  // 3. CALL description() ON BOTH
  //    basicCalc.description() → parent's version
  //    sciCalc.description()   → child's OVERRIDDEN version
  // ============================================================
  print(basicCalc.description()); // Basic calculator
  print(sciCalc.description()); // Scientific calculator with advanced functions

  // ============================================================
  // 4. CALL add() ON BOTH — Same result (inherited, not overridden)
  //    ScientificCalculator didn't override add(), so it uses
  //    the parent's version. Both return the same result.
  // ============================================================
  print(basicCalc.add(3, 5)); // 8.0
  print(sciCalc.add(3, 5)); // 8.0  (inherited, not overridden)

  // ============================================================
  // 5. CALL power() — Only exists on ScientificCalculator
  //    power() is NOT an override — it's a brand-new method.
  //    Only ScientificCalculator has it. If you tried
  //    basicCalc.power(2, 10), you'd get a compile error.
  // ============================================================
  print(sciCalc.power(2, 10)); // 1024.0  (new method, only in child)

  // ============================================================
  //  KEY TAKEAWAY:
  //  @override is a SAFETY annotation. It doesn't change behavior.
  //  It tells Dart: "I'm intentionally replacing a parent method."
  //  If the method doesn't exist in the parent, Dart warns you.
  //  ALWAYS use @override — it catches typos and makes code clearer.
  // ============================================================
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// ---- Parent class: Calculator ----
// Basic calculator with add() and description().
class Calculator {
  double add(double a, double b) {
    return a + b;
  }

  String description() {
    return 'Basic calculator';
  }
}

// ---- Child class: ScientificCalculator ----
// Extends Calculator. Overrides description() but keeps add() as-is.
// Also adds a new method power() that only it has.
class ScientificCalculator extends Calculator {
  // @override tells Dart: "description() exists in Calculator,
  // and I'm intentionally replacing it."
  // If you wrote @override String descriptionn() { ... } (typo),
  // Dart would say: "descriptionn() doesn't exist in Calculator!"
  @override
  String description() {
    return 'Scientific calculator with advanced functions';
  }

  // New method — NOT an override, just an addition.
  // This method doesn't exist in Calculator.
  // Only ScientificCalculator instances can call it.
  double power(double base, double exponent) {
    double result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }
}

// ============================================================
// NOTES: @override Annotation Summary
// ============================================================
//  1. @override is OPTIONAL but STRONGLY recommended
//  2. It doesn't change what the code does — it's a SAFETY tool
//  3. Dart checks: "Does this method actually exist in the parent?"
//  4. If you misspell the method name, Dart catches the typo
//  5. Without @override, a misspelled method just becomes a new method
//
//  OVERRIDE vs NEW METHOD:
//  - Override:    Same name as parent method → replaces parent behavior
//  - New method:  Different name             → adds new behavior alongside inherited ones
//
//  EXAMPLE OF @override CATCHING A BUG:
//  ┌──────────────────────────────────────────────────────────┐
//  │  // WITHOUT @override — BUG goes undetected!            │
//  │  String desription() { return '...'; }  // typo!        │
//  │  // This silently creates a NEW method called            │
//  │  // "desription" and parent's "description" still runs.  │
//  │                                                          │
//  │  // WITH @override — BUG caught immediately!             │
//  │  @override                                               │
//  │  String desription() { return '...'; }  // Dart ERROR!   │
//  │  // Dart says: "desription" is not a method of            │
//  │  // Calculator. Did you mean "description"?               │
//  └──────────────────────────────────────────────────────────┘
// ============================================================
