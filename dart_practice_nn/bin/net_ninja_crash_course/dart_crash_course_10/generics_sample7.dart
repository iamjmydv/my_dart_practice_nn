//------------------------------------------------------------------------------
// G E N E R I C S
//------------------------------------------------------------------------------
// SAMPLE 7: REAL-WORLD EXAMPLE — Menu Collection
//------------------------------------------------------------------------------
//
// This combines multiple concepts:
//   - Generic class: Collection<T> works with any type
//   - Inheritance: Pizza extends MenuItem
//   - toString() override: each item prints differently
//   - Polymorphism: Collection<MenuItem> holds all subtypes
//
// The Collection class doesn't care whether it holds
// MenuItems, Strings, or ints — it works the same way.
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                           | CONCEPTS USED
// -----------------------------------------------------------------------
//  1  | MenuItem and Pizza classes              | Inheritance, toString()
//  2  | Collection<MenuItem> — typed menu       | Generic class
//  3  | Collection<int> and Collection<String>  | Reusability
//  4  | Full menu display                       | Polymorphism
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. MENU ITEMS — Regular items and Pizzas
  //    MenuItem is the base class. Pizza extends MenuItem and
  //    adds toppings. Both have toString() for easy printing.
  // ============================================================
  print('--- 1. Menu Items ---');

  var noodle = MenuItem('Veg Noodles', 9.99);
  var pizza = Pizza(['pepperoni', 'mushrooms'], 'Veg Pizza', 15.99);
  var roast = MenuItem('Veggie Roast Dinner', 12.49);
  var kebab = MenuItem('Plant Kebab', 7.49);

  print(noodle); // Veg Noodles --> $9.99
  print(pizza);
  // PIZZA: Veg Pizza
  //  PRICE: $15.99
  //  TOPPINGS: pepperoni, mushrooms

  print('');

  // ============================================================
  // 2. Collection<MenuItem> — A typed collection of menu items
  //    The Collection class is generic: Collection<T>.
  //    Here T = MenuItem, so it only holds MenuItems (and subclasses
  //    like Pizza, because Pizza IS a MenuItem).
  // ============================================================
  print('--- 2. Collection<MenuItem> ---');

  var menu = Collection<MenuItem>('Food Menu', [noodle, pizza, roast, kebab]);
  print('Collection name: ${menu.name}');
  print('Total items: ${menu.length}');
  print('Random pick: ${menu.randomItem()}');

  print('');

  // ============================================================
  // 3. Collection with simple types — Same class, different types
  //    Collection<int> holds ints, Collection<String> holds Strings.
  //    The generic class works with ANY type, not just MenuItems.
  // ============================================================
  print('--- 3. Collection with other types ---');

  var luckyNumbers = Collection<int>('Lucky Numbers', [7, 13, 21, 42]);
  print('${luckyNumbers.name}: ${luckyNumbers.data}');
  print('Random lucky number: ${luckyNumbers.randomItem()}');

  var greetings = Collection<String>(
    'Greetings',
    ['Hello', 'Hi', 'Hey', 'Howdy'],
  );
  print('Random greeting: ${greetings.randomItem()}');

  print('');

  // ============================================================
  // 4. FULL MENU DISPLAY — Iterate and print everything
  //    Because Collection<MenuItem> holds MenuItems, and Pizza
  //    extends MenuItem, the for loop prints each item using
  //    its own toString() (polymorphism in action).
  // ============================================================
  print('--- 4. Full Menu ---');
  for (var item in menu.data) {
    print(item);
    print('---');
  }
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// MenuItem — base class for all menu items
// Has a title and price. The format() method creates a display string.
// toString() calls format() so print(menuItem) shows the formatted version.
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

// Pizza — extends MenuItem, adds toppings
// Overrides format() to show pizza-specific info.
// super.title and super.price come from MenuItem.
class Pizza extends MenuItem {
  List<String> toppings;

  Pizza(this.toppings, super.title, super.price);

  @override
  String format() {
    var formattedToppings = toppings.join(', ');
    return 'PIZZA: $title\n PRICE: \$$price\n TOPPINGS: $formattedToppings';
  }
}

// Collection<T> — a generic wrapper around a list of any type
// This is the KEY generics example: the SAME class works for
// Collection<MenuItem>, Collection<int>, Collection<String>, etc.
//
// randomItem() returns a value of type T — not dynamic!
// This means Dart knows the exact type of what comes back.
class Collection<T> {
  String name;
  List<T> data;

  Collection(this.name, this.data);

  // Returns a random item — the return type is T, not dynamic!
  // This means Dart knows the exact type of what comes back.
  T randomItem() {
    data.shuffle();
    return data[0];
  }

  int get length => data.length;
}

// ============================================================
// NOTES: Real-World Menu Collection
// ============================================================
//
// THIS SAMPLE TIES EVERYTHING TOGETHER:
// --------------------------------------
//   From Sample 1: Why generics beat dynamic (type safety)
//   From Sample 2: Generic class (Collection<T> like Stack<T>)
//   From Sample 3: Multiple types in one program
//   From Sample 5: Type constraints (Collection<MenuItem> limits types)
//   From Sample 6: Inheritance (Pizza extends MenuItem)
//
// KEY INSIGHT — POLYMORPHISM + GENERICS:
// --------------------------------------
// Collection<MenuItem> can hold:
//   - MenuItem objects
//   - Pizza objects (because Pizza extends MenuItem)
//   - Any future subclass of MenuItem
//
// When you iterate and call toString(), each object uses its OWN
// toString() method. MenuItem prints "title --> $price" while
// Pizza prints the detailed pizza format. That's polymorphism.
//
// REAL-WORLD APPLICATIONS:
// ┌──────────────────────────────┬─────────────────────────────────┐
// │  Generic Class              │  Real-World Use                  │
// ├──────────────────────────────┼─────────────────────────────────┤
// │  Collection<MenuItem>       │  Restaurant menu system          │
// │  Collection<Product>        │  E-commerce product catalog      │
// │  Collection<User>           │  User management system          │
// │  Collection<Notification>   │  Notification center             │
// └──────────────────────────────┴─────────────────────────────────┘
//
// ============================================================
