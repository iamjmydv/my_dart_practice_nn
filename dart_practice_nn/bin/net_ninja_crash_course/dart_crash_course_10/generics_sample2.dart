//------------------------------------------------------------------------------
// G E N E R I C S
//------------------------------------------------------------------------------
// SAMPLE 2: BASIC GENERIC CLASS — Type-safe reusable containers
//------------------------------------------------------------------------------
//
// A generic class uses <T> as a type placeholder.
// When you create an instance, you specify the actual type.
//
// T is just a convention. You could use any letter:
//   <T> = Type, <E> = Element, <K> = Key, <V> = Value
// But T is the most common for single-type generics.
//
// This sample builds a Stack<T> — a last-in-first-out data structure.
// The SAME class works with int, String, or any other type.
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                           | WHY IT MATTERS
// -----------------------------------------------------------------------
//  1  | Stack<int> — push and pop numbers      | Generic class with int
//  2  | Stack<String> — same class, Strings    | Reusability without rewriting
//  3  | Type safety with Stack<T>              | Can't mix types accidentally
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. Stack<int> — A stack of numbers
  //    push() adds to the top, pop() removes from the top.
  //    peek() looks at the top without removing it.
  //    This is the classic LIFO (Last In, First Out) pattern.
  // ============================================================
  print('--- 1. Stack<int> ---');

  var numberStack = Stack<int>();
  numberStack.push(10);
  numberStack.push(20);
  numberStack.push(30);
  print(numberStack); // Stack: [10, 20, 30]
  print('Popped: ${numberStack.pop()}'); // Popped: 30
  print('Peek: ${numberStack.peek()}'); // Peek: 20
  print(numberStack); // Stack: [10, 20]
  print('Size: ${numberStack.length}'); // Size: 2
  print('Empty? ${numberStack.isEmpty}'); // Empty? false

  print('');

  // ============================================================
  // 2. Stack<String> — The SAME Stack class works with Strings
  //    No rewriting needed! The generic type T becomes String.
  //    Every method (push, pop, peek) now works with Strings.
  // ============================================================
  print('--- 2. Stack<String> ---');

  var wordStack = Stack<String>();
  wordStack.push('apple');
  wordStack.push('banana');
  wordStack.push('cherry');
  print(wordStack); // Stack: [apple, banana, cherry]
  print('Popped: ${wordStack.pop()}'); // Popped: cherry
  print(wordStack); // Stack: [apple, banana]

  print('');

  // ============================================================
  // 3. TYPE SAFETY — Can't mix types
  //    numberStack only accepts int. wordStack only accepts String.
  //    Dart catches mistakes at compile time.
  // ============================================================
  print('--- 3. Type safety ---');
  print('numberStack only accepts int');
  print('wordStack only accepts String');
  print('Try uncommenting: numberStack.push("hello");');
  // numberStack.push('hello');  // Compile error! Can't push String into Stack<int>
  // wordStack.push(42);         // Compile error! Can't push int into Stack<String>
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// Stack<T> — a last-in-first-out (LIFO) data structure
// Works with any type: Stack<int>, Stack<String>, Stack<MyClass>, etc.
//
// How it works:
//   push(item) → adds item to the TOP of the stack
//   pop()      → removes and returns the TOP item
//   peek()     → looks at the TOP item without removing it
//
// The internal list _items stores everything. The underscore makes it private.
class Stack<T> {
  final List<T> _items = [];

  // Push an item onto the top of the stack
  void push(T item) {
    _items.add(item);
  }

  // Remove and return the top item
  // Throws an error if the stack is empty (can't pop nothing!)
  T pop() {
    if (_items.isEmpty) throw StateError('Stack is empty');
    return _items.removeLast();
  }

  // Look at the top item without removing it
  // Throws an error if the stack is empty
  T peek() {
    if (_items.isEmpty) throw StateError('Stack is empty');
    return _items.last;
  }

  // Utility getters
  bool get isEmpty => _items.isEmpty;
  int get length => _items.length;

  @override
  String toString() => 'Stack: $_items';
}

// ============================================================
// NOTES: Basic Generic Class
// ============================================================
//
// GENERIC CLASS SYNTAX:
// ---------------------
//   class ClassName<T> {
//     T someField;
//     T someMethod() { ... }
//   }
//
// USING IT:
// ---------
//   var obj = ClassName<int>();    // T becomes int everywhere
//   var obj = ClassName<String>(); // T becomes String everywhere
//
// TYPE PARAMETER CONVENTIONS:
// ---------------------------
//   T  → Type          (general purpose, most common)
//   E  → Element       (used in collections like List<E>)
//   K  → Key           (used in maps like Map<K, V>)
//   V  → Value         (used in maps like Map<K, V>)
//   R  → Return type   (used in function types)
//
// WHY THIS MATTERS:
// -----------------
// Without generics, you'd need separate classes:
//   IntStack, StringStack, BoolStack, DoubleStack...
// With generics, ONE class handles all types safely.
//
// ============================================================
