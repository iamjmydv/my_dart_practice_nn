//------------------------------------------------------------------------------
// M E T H O D - O V E R R I D I N G
//------------------------------------------------------------------------------
// SAMPLE 1: BASIC METHOD OVERRIDE — Replace Inherited Behavior
//------------------------------------------------------------------------------
//
// Method overriding lets a child class REPLACE a method it inherited
// from a parent class with its own version. The method keeps the same
// name and parameters, but the behavior changes.
//
// Think of it like this: a parent class says "here's how to do X",
// and the child class says "no thanks, I'll do X my own way."
//
// When a child class has the SAME method name as its parent,
// the child's version wins. The parent's version is ignored
// unless you explicitly call it with "super".
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                           | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Parent class defines speak()           | Default behavior for all animals
//  2  | Child class overrides speak()          | Cat has its own version of speak()
//  3  | Call speak() on both parent and child  | See which version runs for each type
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. CREATE AN ANIMAL (parent class)
  //    Animal has a speak() method that returns a generic message.
  //    Every Animal "makes a sound" — nothing specific.
  // ============================================================
  var anyAnimal = Animal('some animal');

  // ============================================================
  // 2. CREATE A CAT (child class that overrides speak())
  //    Cat extends Animal, so it inherits everything from Animal.
  //    But Cat defines its OWN speak() method — this replaces
  //    the parent's version. Cat says "Meow!" instead of
  //    "makes a sound."
  // ============================================================
  var cat = Cat('Whiskers');

  // ============================================================
  // 3. CALL speak() ON BOTH — See the difference
  //    - anyAnimal.speak() calls Animal's version
  //    - cat.speak() calls Cat's OVERRIDDEN version
  //    The method name is the same, but the behavior differs.
  // ============================================================
  print(anyAnimal.speak()); // some animal makes a sound
  print(cat.speak()); // Whiskers says: Meow!  (overridden)

  // ============================================================
  //  KEY TAKEAWAY:
  //  The child class (Cat) completely REPLACES the parent's speak().
  //  When you call cat.speak(), Dart runs Cat's version — not Animal's.
  //  This is the most basic form of method overriding.
  // ============================================================
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// ---- Parent class: Animal ----
// The base class with a default speak() method.
// Any class that extends Animal will inherit speak().
class Animal {
  String name;

  Animal(this.name);

  // Default behavior — every animal "makes a sound"
  String speak() {
    return '$name makes a sound';
  }
}

// ---- Child class: Cat ----
// Cat extends Animal, inheriting the name field and speak() method.
// But Cat OVERRIDES speak() with its own version.
// The @override annotation is optional but STRONGLY recommended.
// It tells Dart: "I intend to replace a parent method."
class Cat extends Animal {
  Cat(super.name);

  @override
  String speak() {
    return '$name says: Meow!';
  }
}

// ============================================================
// NOTES: Basic Method Override Summary
// ============================================================
//  1. Override = child class defines a method with the SAME NAME as parent
//  2. The child's version REPLACES the parent's version
//  3. The method name and parameters must match exactly
//  4. Use @override annotation to signal intent and catch typos
//  5. Without override, the parent's method is inherited as-is
//
//  ANALOGY:
//  Parent says: "All animals make a sound."
//  Cat says:    "Actually, I say Meow!"
//  The Cat's version wins whenever you call speak() on a Cat.
// ============================================================
