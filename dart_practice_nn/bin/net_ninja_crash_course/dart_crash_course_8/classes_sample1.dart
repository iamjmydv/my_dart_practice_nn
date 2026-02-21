//------------------------------------------------------------------------------
// C L A S S E S  —  S A M P L E  1
//------------------------------------------------------------------------------
//
// Basic Class, Constructor & Methods
//
// This file covers the first three class concepts in Dart:
//   1. Basic class with properties (Fruit)
//   2. Class with constructor (Car)
//   3. Class with methods (Book)
//
// -----------------------------------------------------------------------
//  #  | TOPIC                          | KEYWORDS USED            | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Basic class with properties    | class, properties        | Blueprint for creating objects
//  2  | Class with constructor         | this, constructor        | Initialize properties when creating objects
//  3  | Class with methods             | methods, return          | Give objects behavior and actions
// -----------------------------------------------------------------------
//
//------------------------------------------------------------------------------

void main() {
  // ============================================================
  // 1. BASIC CLASS WITH PROPERTIES - A class is a blueprint
  //    When you create a class, you define what data (properties)
  //    an object will hold. Creating an object from a class is
  //    called "instantiation". Access properties with dot notation.
  // ============================================================
  var apple = Fruit();
  var banana = Fruit();

  print(apple.name); // apple
  print(apple.color); // red
  print(banana.weight); // 0.25

  // ============================================================
  // 2. CLASS WITH CONSTRUCTOR - Initialize properties at creation
  //    A constructor runs when you create an object. Using
  //    "this.property" in the constructor automatically assigns
  //    the argument to the property. This lets you create
  //    objects with different values each time.
  // ============================================================
  var civic = Car('Honda', 'Civic', 2023);
  var corolla = Car('Toyota', 'Corolla', 2024);

  print(civic.brand); // Honda
  print(civic.model); // Civic
  print(corolla.year); // 2024

  // ============================================================
  // 3. CLASS WITH METHODS - Give objects behavior
  //    Methods are functions inside a class. They can access
  //    the object's own properties using their names directly.
  //    Use methods to perform actions or return computed values.
  // ============================================================
  var harryPotter = Book('Harry Potter', 'J.K. Rowling', 400);
  var shortStory = Book('The Gift', 'O. Henry', 50);

  print(harryPotter.summary()); // "Harry Potter" by J.K. Rowling (400 pages)
  print(harryPotter.isLong()); // true (more than 300 pages)
  print(shortStory.isLong()); // false
}

// ============================================================
//  CLASS DEFINITIONS
//  (Dart allows class definitions after main — the compiler
//   reads the entire file before running, so order doesn't matter)
// ============================================================

// ---- Section 1: Basic class with default properties ----
// A class is a blueprint for creating objects.
// Properties with default values are set when the class is defined.
// Every object created from this class starts with the same values.
class Fruit {
  String name = 'apple';
  String color = 'red';
  double weight = 0.25;
}

// ---- Section 2: Class with constructor ----
// A constructor is a special method that runs when you create an object.
// "this.brand" is shorthand for: this.brand = brand;
// It automatically assigns the argument to the property.
class Car {
  String brand;
  String model;
  int year;

  Car(this.brand, this.model, this.year);
}

// ---- Section 3: Class with methods ----
// Methods are functions defined inside a class.
// They can access the object's own properties directly.
// summary() returns a formatted string, isLong() returns a bool.
class Book {
  String title;
  String author;
  int pages;

  Book(this.title, this.author, this.pages);

  String summary() {
    return '"$title" by $author ($pages pages)';
  }

  bool isLong() {
    return pages > 300;
  }
}

// =============================================================================
//  NOTES: Sample 1 — Basic Class, Constructor & Methods
// =============================================================================
//
//  CONCEPT           | WHAT IT DOES                        | EXAMPLE
// -------------------|-------------------------------------|--------------------
//  class             | Defines a blueprint for objects     | class Fruit { ... }
//  properties        | Data stored inside an object        | String name = 'apple';
//  constructor       | Runs when creating an object        | Car(this.brand, ...);
//  this.property     | Shorthand to assign constructor arg | this.brand = brand
//  methods           | Functions inside a class            | String summary() { ... }
//  instantiation     | Creating an object from a class     | var apple = Fruit();
//  dot notation      | Access properties/methods           | apple.name, book.summary()
//
//  KEY TAKEAWAYS:
//  - A class without a constructor uses default property values
//  - A constructor with "this.property" is the most common pattern
//  - Methods can read and use the object's own properties
//  - Objects are independent — changing one doesn't affect others
//
// =============================================================================
