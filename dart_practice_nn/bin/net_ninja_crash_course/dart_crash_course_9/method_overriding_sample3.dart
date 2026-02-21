//------------------------------------------------------------------------------
// M E T H O D - O V E R R I D I N G
//------------------------------------------------------------------------------
// SAMPLE 3: CALLING SUPER INSIDE AN OVERRIDE — Extend, Don't Replace
//------------------------------------------------------------------------------
//
// Sometimes you don't want to throw away the parent's work.
// Use "super.methodName()" inside your override to run the
// parent's version FIRST, then add your own logic on top.
//
// Think of it as: "Do everything the parent does, PLUS more."
//
// Without super: Child completely REPLACES parent behavior.
// With super:    Child EXTENDS parent behavior (keeps it + adds to it).
//
// -----------------------------------------------------------------------
//  #  | WHAT HAPPENS                                | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Parent Logger prints a basic [LOG] message  | Base logging behavior
//  2  | Child calls super.log() inside its override | Reuses parent's formatting
//  3  | Child appends a timestamp after super call  | Extends without rewriting
// -----------------------------------------------------------------------
//
void main() {
  // ============================================================
  // 1. CREATE A BASIC LOGGER (parent class)
  //    Logger.log() prints: [LOG] <message>
  //    This is the base behavior that all loggers share.
  // ============================================================
  var basicLogger = Logger();

  // ============================================================
  // 2. CREATE A TIMESTAMP LOGGER (child class)
  //    TimestampLogger overrides log(), but instead of replacing
  //    the parent's behavior entirely, it CALLS super.log() first
  //    and then adds a timestamp to the message.
  //
  //    Flow:
  //      1. TimestampLogger.log('Server started') is called
  //      2. Inside, it builds a new message with the timestamp
  //      3. It calls super.log(newMessage) — which runs Logger.log()
  //      4. Logger.log() prints [LOG] Server started | Logged at: <time>
  // ============================================================
  var timestampLogger = TimestampLogger();

  // ============================================================
  // 3. CALL log() ON BOTH — See the difference
  //    basicLogger.log() → just the message
  //    timestampLogger.log() → message + timestamp (because of super)
  // ============================================================
  basicLogger.log('Server started');
  // Output: [LOG] Server started

  timestampLogger.log('Server started');
  // Output: [LOG] Server started | Logged at: <timestamp>

  // ============================================================
  //  KEY TAKEAWAY:
  //  super.method() lets you REUSE the parent's code inside your
  //  override. You don't have to rewrite the [LOG] formatting —
  //  just call super.log() and add your extra logic.
  //
  //  WHEN TO USE SUPER:
  //  - When you want to EXTEND behavior (keep parent's + add yours)
  //  - When you want to MODIFY the input before passing to parent
  //  - When the parent's code is complex and you don't want to copy it
  //
  //  WHEN NOT TO USE SUPER:
  //  - When you want to COMPLETELY REPLACE the parent's behavior
  //  - When the parent's behavior doesn't apply to the child at all
  // ============================================================
}

// ============================================================
//  CLASS DEFINITIONS
// ============================================================

// ---- Parent class: Logger ----
// Simple logger that prints messages with a [LOG] prefix.
class Logger {
  void log(String message) {
    print('[LOG] $message');
  }
}

// ---- Child class: TimestampLogger ----
// Extends Logger. Overrides log() but calls super.log() inside
// to reuse the parent's [LOG] formatting. Then adds a timestamp.
class TimestampLogger extends Logger {
  @override
  void log(String message) {
    // Instead of rewriting the [LOG] prefix logic, we build
    // a new message with the timestamp and pass it to the parent.
    // super.log() runs Logger.log(), which adds the [LOG] prefix.
    var timestamp = DateTime.now().toIso8601String();
    super.log('$message | Logged at: $timestamp');
  }
}

// ============================================================
// NOTES: Calling Super Inside an Override — Summary
// ============================================================
//  1. super.method() calls the PARENT's version of the method
//  2. You can call super BEFORE or AFTER your own logic
//  3. super only reaches ONE level up (parent, not grandparent)
//  4. Use super when you want to EXTEND, not REPLACE
//
//  PATTERNS:
//  ┌──────────────────────────────────────────────────────────┐
//  │  // Pattern A: Run parent first, then add your logic     │
//  │  @override                                               │
//  │  void method() {                                         │
//  │    super.method();       // parent runs first            │
//  │    // your extra logic   // then your stuff              │
//  │  }                                                       │
//  │                                                          │
//  │  // Pattern B: Do your logic first, then call parent     │
//  │  @override                                               │
//  │  void method() {                                         │
//  │    // your preparation   // your stuff first             │
//  │    super.method();       // then parent runs             │
//  │  }                                                       │
//  │                                                          │
//  │  // Pattern C: Modify input, then pass to parent         │
//  │  @override                                               │
//  │  void log(String msg) {                                  │
//  │    var enhanced = '$msg | extra info';                    │
//  │    super.log(enhanced);  // parent gets enhanced input   │
//  │  }                                                       │
//  └──────────────────────────────────────────────────────────┘
// ============================================================
