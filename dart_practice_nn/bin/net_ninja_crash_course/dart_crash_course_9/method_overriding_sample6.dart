//------------------------------------------------------------------------------
// M E T H O D - O V E R R I D I N G
//------------------------------------------------------------------------------
// SAMPLE 6: REAL-WORLD EXAMPLE — Menu Items (Combines All Override Concepts)
//------------------------------------------------------------------------------
//
// This sample combines multiple override concepts:
//   - Basic override: Pizza replaces format() with its own
//   - toString() override: MenuItem uses format() inside toString()
//   - Polymorphism: print() calls the correct format() for each type
//
// When you call print(pizza), Dart calls:
//   pizza.toString() -> pizza.format() (the overridden version)
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                              | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | MenuItem has format() and toString()      | Base formatting for all menu items
//  2  | Pizza overrides format() with toppings    | Custom format for pizza
//  3  | Burger overrides format() with combo info | Custom format for burgers
//  4  | Polymorphism: list of MenuItems prints    | Each item uses its own format()
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. CREATE DIFFERENT MENU ITEMS
  //    All three are MenuItems, but Pizza and Burger have their
  //    own format() methods that override the parent's version.
  // ============================================================
  var noodle = MenuItem('Veg Noodles', 9.99);
  var pizza = Pizza(['peppers', 'mushrooms', 'olives'], 'Veg Pizza', 15.99);
  var burger = Burger('Classic Burger', 12.49, true);

  // ============================================================
  // 2. PRINT EACH ITEM — toString() calls format()
  //    When you call print(object), Dart calls object.toString().
  //    MenuItem.toString() calls format(). But WHICH format()?
  //    The one defined by the ACTUAL type of the object!
  //
  //    noodle → MenuItem.format()   (no override, uses parent)
  //    pizza  → Pizza.format()      (overridden version)
  //    burger → Burger.format()     (overridden version)
  // ============================================================
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

  // ============================================================
  // 3. POLYMORPHISM IN ACTION — A list of MenuItems
  //    Even though the list type is List<MenuItem>, each item
  //    uses its OWN format() method. Dart checks the ACTUAL type
  //    at runtime, not the declared type.
  //
  //    This is the power of polymorphism + method overriding:
  //    One interface (MenuItem), many behaviors (Pizza, Burger, etc.)
  // ============================================================
  var menu = <MenuItem>[noodle, pizza, burger];
  print('\n--- Full Menu ---');
  for (var item in menu) {
    print(item); // calls the correct overridden format() for each type
    print('---');
  }

  // ============================================================
  //  KEY TAKEAWAY:
  //  This example shows how method overriding works in real apps:
  //  1. Define a base class with default behavior (MenuItem.format())
  //  2. Each subclass overrides format() to customize its output
  //  3. toString() delegates to format() — so print() just works
  //  4. Polymorphism lets you treat all items as MenuItem but get
  //     the correct format() for each type automatically
  // ============================================================
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// ---- Base class: MenuItem ----
// Has format() for basic formatting and toString() that calls format().
// Subclasses override format() to customize their output.
class MenuItem {
  String title;
  double price;

  MenuItem(this.title, this.price);

  // Default format: "Title --> $Price"
  String format() {
    return '$title --> \$$price';
  }

  // toString() delegates to format().
  // When a subclass overrides format(), toString() automatically
  // picks up the overridden version. This is polymorphism at work.
  @override
  String toString() {
    return format();
  }
}

// ---- Child class: Pizza ----
// Overrides format() to include toppings in a multi-line layout.
class Pizza extends MenuItem {
  List<String> toppings;

  Pizza(this.toppings, super.title, super.price);

  @override
  String format() {
    var formattedToppings = toppings.join(', ');
    return 'PIZZA: $title\n PRICE: \$$price\n TOPPINGS: $formattedToppings';
  }
}

// ---- Child class: Burger ----
// Overrides format() to include combo information.
class Burger extends MenuItem {
  bool isCombo;

  Burger(super.title, super.price, this.isCombo);

  @override
  String format() {
    return 'BURGER: $title\n PRICE: \$$price\n Combo: ${isCombo ? "Yes" : "No"}';
  }
}

// ============================================================
// NOTES: Real-World Menu Example — Summary
// ============================================================
//  This sample demonstrates ALL override concepts together:
//
//  1. BASIC OVERRIDE:
//     Pizza.format() and Burger.format() replace MenuItem.format()
//
//  2. toString() OVERRIDE:
//     MenuItem.toString() calls format() — and polymorphism ensures
//     the correct format() runs based on the actual object type.
//
//  3. POLYMORPHISM:
//     A List<MenuItem> can hold Pizza, Burger, etc.
//     When you loop and print, each item uses its own format().
//
//  4. DESIGN PATTERN: Template Method
//     MenuItem.toString() defines the STRUCTURE (call format()),
//     and subclasses fill in the DETAILS by overriding format().
//     This is the "Template Method" pattern.
//
//  HOW PRINT(PIZZA) WORKS — Step by step:
//  ┌──────────────────────────────────────────────────────────┐
//  │  print(pizza)                                            │
//  │    → Dart calls pizza.toString()                         │
//  │    → toString() calls this.format()                      │
//  │    → "this" is a Pizza, so Pizza.format() runs           │
//  │    → Returns multi-line pizza format with toppings        │
//  │    → print() outputs the result                          │
//  └──────────────────────────────────────────────────────────┘
// ============================================================
