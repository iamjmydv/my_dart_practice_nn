//------------------------------------------------------------------------------
// G E N E R I C S
//------------------------------------------------------------------------------
// SAMPLE 1: THE PROBLEM WITHOUT GENERICS — Why dynamic is risky
//------------------------------------------------------------------------------
//
// Without generics, you'd use "dynamic" or "Object" to accept any type.
// But then Dart can't help you catch mistakes at compile time.
//
// Imagine a box that holds items. Without generics, you can accidentally
// put a String where you expected an int. With generics, Dart catches
// the mistake BEFORE you run.
//
// This sample shows TWO approaches:
//   1. UnsafeBox — uses dynamic, no type safety (BAD)
//   2. SafeBox<T> — uses generics, full type safety (GOOD)
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                           | WHY IT MATTERS
// -----------------------------------------------------------------------
//  1  | UnsafeBox with dynamic                 | No compile-time checks
//  2  | SafeBox<T> with generics               | Compile-time type safety
//  3  | Trying to misuse SafeBox               | Dart catches errors early
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. WITHOUT GENERICS — UnsafeBox uses dynamic, no type safety
  //    The box accepts anything. Dart doesn't know what's inside.
  //    You could put a String in, then try to use it as an int,
  //    and Dart wouldn't warn you until the program crashes.
  // ============================================================
  print('--- 1. UnsafeBox (dynamic — no type safety) ---');

  // Create an UnsafeBox with a String
  var unsafeBox = UnsafeBox('Hello');
  print(unsafeBox.item); // Hello
  print(unsafeBox.item.runtimeType); // String

  // This compiles fine, but could crash at runtime if you
  // tried to use .item as an int when it's actually a String:
  var anotherUnsafeBox = UnsafeBox(42);
  print(anotherUnsafeBox.item); // 42

  // DANGER: This would crash at runtime (can't add String + int):
  // unsafeBox.item + anotherUnsafeBox.item;  // Runtime crash!

  print('');

  // ============================================================
  // 2. WITH GENERICS — SafeBox<T> knows the exact type
  //    When you create SafeBox<String>, Dart KNOWS the item is a
  //    String. When you create SafeBox<int>, Dart KNOWS it's int.
  //    No guessing, no runtime surprises.
  // ============================================================
  print('--- 2. SafeBox<T> (generics — type safe!) ---');

  var safeStringBox = SafeBox<String>('Hello');
  var safeIntBox = SafeBox<int>(42);
  print(safeStringBox.item); // Hello
  print(safeIntBox.item); // 42

  // Dart knows safeStringBox.item is a String, so you can
  // safely use String methods on it:
  print(safeStringBox.item.toUpperCase()); // HELLO
  print(safeIntBox.item.isEven); // true

  print('');

  // ============================================================
  // 3. TYPE SAFETY IN ACTION
  //    This would cause a COMPILE-TIME error (caught before running!):
  //    var badBox = SafeBox<int>('Hello');  // Error! String is not int
  //
  //    That's the whole point of generics — mistakes are caught
  //    BEFORE you even run the program, not after a user hits a bug.
  // ============================================================
  print('--- 3. Type safety comparison ---');
  print('UnsafeBox: accepts anything, no safety');
  print('SafeBox<T>: only accepts the type you specified');
  print('Try uncommenting: var badBox = SafeBox<int>("Hello");');
  // var badBox = SafeBox<int>('Hello');  // Compile error!
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// WITHOUT generics — accepts anything, no type checking
// The "dynamic" type means Dart won't check what goes in or comes out.
// This is like a box with no label — you never know what's inside.
class UnsafeBox {
  dynamic item; // could be anything — int, String, bool...

  UnsafeBox(this.item);
}

// WITH generics — T is a placeholder for the actual type
// When you write SafeBox<String>, T becomes String everywhere.
// When you write SafeBox<int>, T becomes int everywhere.
// It's like putting a label on the box: "This box holds Strings only."
class SafeBox<T> {
  T item;

  SafeBox(this.item);
}

// ============================================================
// NOTES: The Problem Without Generics
// ============================================================
//
// WHY NOT USE dynamic?
// --------------------
// dynamic turns OFF Dart's type system for that variable.
//   dynamic x = 'hello';
//   x.foo();  // Compiles fine, but crashes at runtime!
//
// WHY NOT USE Object?
// -------------------
// Object is type-safe but you lose the specific type info.
//   Object x = 'hello';
//   x.length;  // Error! Object has no .length property
//
// WHY USE GENERICS?
// -----------------
// Generics give you the BEST of both worlds:
//   SafeBox<String> x = SafeBox('hello');
//   x.item.length;  // Works! Dart knows x.item is a String
//
// COMPARISON:
// ┌──────────────┬──────────────┬──────────────────────────────┐
// │  Approach    │  Type Safe?  │  Keeps Specific Type Info?   │
// ├──────────────┼──────────────┼──────────────────────────────┤
// │  dynamic     │  NO          │  NO                          │
// │  Object      │  YES         │  NO                          │
// │  Generics    │  YES         │  YES                         │
// └──────────────┴──────────────┴──────────────────────────────┘
//
// ============================================================
