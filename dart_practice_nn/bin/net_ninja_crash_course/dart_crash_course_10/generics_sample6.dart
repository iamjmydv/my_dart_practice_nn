//------------------------------------------------------------------------------
// G E N E R I C S
//------------------------------------------------------------------------------
// SAMPLE 6: GENERICS WITH INHERITANCE — Combine generics + class hierarchies
//------------------------------------------------------------------------------
//
// Generic classes can extend other generic classes.
// This lets you build specialized versions of generic containers.
//
//   Base:   Repository<T>         — basic CRUD operations
//   Child:  LoggedRepository<T>   — adds logging to every operation
//
// The child class inherits ALL generic behavior from the parent,
// and can override methods to add new functionality.
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                           | WHY IT MATTERS
// -----------------------------------------------------------------------
//  1  | LoggedRepository<String> — user repo   | Logging on add/remove
//  2  | LoggedRepository<int> — number repo    | Same class, different type
//  3  | Base Repository methods still work     | Inherited getAll, getById
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. LoggedRepository<String> — A user repository with logging
  //    Every time you add or remove an item, it prints a log message.
  //    The base Repository<T> handles the actual storage.
  //    LoggedRepository<T> just adds logging on top.
  // ============================================================
  print('--- 1. LoggedRepository<String> ---');

  var userRepo = LoggedRepository<String>('UserRepo');
  userRepo.add('Alice');
  // Prints: [UserRepo] Added: Alice
  userRepo.add('Bob');
  // Prints: [UserRepo] Added: Bob
  userRepo.add('Carol');
  // Prints: [UserRepo] Added: Carol

  print('All users: ${userRepo.getAll()}'); // All users: [Alice, Bob, Carol]
  print('First: ${userRepo.getById(0)}'); // First: Alice
  print('Count: ${userRepo.length}'); // Count: 3

  print('');

  // Remove an item — also logged
  userRepo.remove('Bob');
  // Prints: [UserRepo] Removed: Bob
  print('After remove: ${userRepo.getAll()}'); // After remove: [Alice, Carol]

  print('');

  // ============================================================
  // 2. LoggedRepository<int> — Same class works with any type
  //    The generic type T is passed from LoggedRepository<int>
  //    up to the parent Repository<int>. Everything is type-safe.
  // ============================================================
  print('--- 2. LoggedRepository<int> ---');

  var numberRepo = LoggedRepository<int>('NumberRepo');
  numberRepo.add(100);
  // Prints: [NumberRepo] Added: 100
  numberRepo.add(200);
  // Prints: [NumberRepo] Added: 200
  numberRepo.add(300);
  // Prints: [NumberRepo] Added: 300

  print('Numbers: ${numberRepo.getAll()}'); // Numbers: [100, 200, 300]
  print('Second: ${numberRepo.getById(1)}'); // Second: 200

  print('');

  // ============================================================
  // 3. BASE REPOSITORY — Works without logging too
  //    You can also use the base Repository<T> directly
  //    if you don't need logging. Same API, less output.
  // ============================================================
  print('--- 3. Base Repository<double> ---');

  var priceRepo = Repository<double>();
  priceRepo.add(9.99);
  priceRepo.add(15.49);
  priceRepo.add(3.99);
  print('Prices: ${priceRepo.getAll()}'); // Prices: [9.99, 15.49, 3.99]
  print('Count: ${priceRepo.length}'); // Count: 3
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// Base generic class — simple in-memory repository
// Provides basic CRUD (Create, Read, Update, Delete) operations.
// Any type can be stored: Repository<String>, Repository<int>, etc.
class Repository<T> {
  final List<T> _items = [];

  // CREATE — add an item to the repository
  void add(T item) {
    _items.add(item);
  }

  // DELETE — remove an item from the repository
  void remove(T item) {
    _items.remove(item);
  }

  // READ — get a single item by index
  T getById(int index) {
    return _items[index];
  }

  // READ — get all items (returns an unmodifiable copy)
  List<T> getAll() {
    return List.unmodifiable(_items);
  }

  // Utility getter
  int get length => _items.length;
}

// Child generic class — adds logging to every operation
// Extends Repository<T>, so it inherits add, remove, getById, getAll.
// Overrides add() and remove() to print log messages before calling super.
//
// The "extends Repository<T>" means:
//   - LoggedRepository<String> extends Repository<String>
//   - LoggedRepository<int> extends Repository<int>
//   - The T flows through the entire hierarchy
class LoggedRepository<T> extends Repository<T> {
  String repoName;

  LoggedRepository(this.repoName);

  @override
  void add(T item) {
    print('[$repoName] Added: $item');
    super.add(item); // call the parent's add() to actually store it
  }

  @override
  void remove(T item) {
    print('[$repoName] Removed: $item');
    super.remove(item); // call the parent's remove() to actually delete it
  }
}

// ============================================================
// NOTES: Generics with Inheritance
// ============================================================
//
// SYNTAX:
// -------
//   class Parent<T> { ... }
//   class Child<T> extends Parent<T> { ... }
//
// HOW THE TYPE FLOWS:
// -------------------
//   LoggedRepository<String> extends Repository<String>
//   LoggedRepository<int>    extends Repository<int>
//
//   The child passes its T to the parent's T.
//   Both classes use the SAME type parameter.
//
// YOU CAN ALSO FIX THE TYPE:
// --------------------------
//   class StringRepo extends Repository<String> { ... }
//   Now StringRepo ALWAYS stores Strings — no generic needed.
//
// OVERRIDING METHODS:
// -------------------
//   @override makes sure the method signature matches the parent.
//   super.add(item) calls the parent's original add() method.
//   This lets you ADD behavior (logging) without REPLACING behavior.
//
// REAL-WORLD USE CASES:
// ---------------------
//   Base: ApiService<T>        → generic HTTP client
//   Child: UserService         → extends ApiService<User>
//   Child: ProductService      → extends ApiService<Product>
//
//   Base: Cache<T>             → generic in-memory cache
//   Child: TimedCache<T>       → extends Cache<T>, adds expiration
//
// ============================================================
