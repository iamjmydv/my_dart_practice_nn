//------------------------------------------------------------------------------
// F E T C H I N G   D A T A   F R O M   T H E   I N T E R N E T
//------------------------------------------------------------------------------
//
// This file shows how to make HTTP requests in Dart to fetch data from a
// REST API. We use the `http` package to send a GET request, then parse
// the JSON response into a Dart object.
//
// Think of it like ordering food from a restaurant:
//   1. You place an order (send an HTTP request to a URL)
//   2. The kitchen prepares it (server processes the request)
//   3. The waiter brings your food (server sends back a response)
//   4. You eat it (parse the response and use the data)
//
// -----------------------------------------------------------------------
//  STEP | WHAT HAPPENS                        | KEY CONCEPTS
// -----------------------------------------------------------------------
//   1   | Import the http package             | External package dependency
//   2   | Import dart:convert                 | Built-in JSON decoder
//   3   | Build the URL with Uri.https()      | Safe URL construction
//   4   | Send GET request with http.get()    | Async HTTP call (returns Future)
//   5   | Check status code                   | Error handling for bad responses
//   6   | Decode JSON with jsonDecode()       | Convert JSON string → Dart Map
//   7   | Map the data into a Post object     | JSON → Dart class (model)
// -----------------------------------------------------------------------
//
// API used: https://jsonplaceholder.typicode.com/posts/1
// This is a free fake REST API for testing and prototyping.
//
//------------------------------------------------------------------------------

// =============================================================================
//  I M P O R T S
// =============================================================================

// The `http` package lets us make HTTP requests (GET, POST, PUT, DELETE).
// We import it with the alias `http` so we can call http.get(), http.post(), etc.
// This is an EXTERNAL package — it must be added to pubspec.yaml first:
//   dependencies:
//     http: ^1.1.0
// Then run `dart pub get` to download it.
import 'package:http/http.dart' as http;

// `dart:convert` is a BUILT-IN Dart library (no pubspec.yaml needed).
// It provides jsonDecode() to convert a JSON string into a Dart Map/List,
// and jsonEncode() to convert a Dart Map/List into a JSON string.
// We alias it as `convert` so we call convert.jsonDecode().
import 'dart:convert' as convert;

// =============================================================================
// =============================================================================
//
//  M A I N   F U N C T I O N
//
//  The entry point of the program.
//  - Marked `async` because we use `await` inside it.
//  - Calls fetchPost() which returns a Future<Post>.
//  - `await` pauses here until the HTTP request completes and we get a Post.
//  - Then we print the Post's title and userId.
//
// =============================================================================
// =============================================================================

void main() async {
  // fetchPost() makes an HTTP request to the API and returns a Post object.
  // `await` pauses execution here until the Future completes (the response
  // comes back from the server). Without `await`, we'd get a Future<Post>
  // instead of an actual Post.
  final post = await fetchPost();

  // Now we have the Post object — print its properties.
  print('Title: ${post.title}');
  print('UserId: ${post.userId}');
}

// =============================================================================
// =============================================================================
//
//  F E T C H   P O S T   F U N C T I O N
//
//  Makes an HTTP GET request to jsonplaceholder.typicode.com/posts/1
//  and returns a Post object parsed from the JSON response.
//
//  Flow:
//    1. Build the URL using Uri.https()
//    2. Send a GET request using http.get()
//    3. Check if the response was successful (status code 200)
//    4. Decode the JSON response body into a Dart Map
//    5. Create and return a Post object from the Map
//
//  Returns: Future<Post> — a Future because HTTP requests are async
//           (we have to WAIT for the server to respond).
//
// =============================================================================
// =============================================================================

// The full URL we're hitting: https://jsonplaceholder.typicode.com/posts/1
Future<Post> fetchPost() async {
  // ============================================================
  // STEP 1: Build the URL
  // ============================================================
  // Uri.https() constructs a proper HTTPS URL from parts:
  //   - 1st argument: the host/domain (WITHOUT https://)
  //   - 2nd argument: the path (starts with /)
  //
  // This creates: https://jsonplaceholder.typicode.com/posts/1
  //
  // Why use Uri.https() instead of a plain string?
  //   - It handles special characters (spaces, &, ?, etc.) automatically
  //   - It validates the URL structure
  //   - It supports query parameters as a 3rd argument (Map)
  //     Example: Uri.https('example.com', '/search', {'q': 'dart'})
  //              → https://example.com/search?q=dart
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/1');

  // ============================================================
  // STEP 2: Send the GET request
  // ============================================================
  // http.get() sends an HTTP GET request to the given URL.
  // - It returns a Future<Response>, so we `await` it.
  // - The `headers` parameter is optional — here we tell the server
  //   we want JSON back by setting 'Accept': 'application/json'.
  // - The Response object contains:
  //     response.statusCode  → HTTP status code (200 = OK, 404 = Not Found, etc.)
  //     response.body        → The response body as a String (the JSON data)
  //     response.headers     → Response headers from the server
  final response = await http.get(uri, headers: {'Accept': 'application/json'});

  // ============================================================
  // STEP 3: Check if the request was successful
  // ============================================================
  // HTTP status code 200 means "OK" — the request succeeded.
  // If we get anything else (404, 500, etc.), something went wrong.
  //
  // Common status codes:
  //   200 = OK (success)
  //   201 = Created (POST success)
  //   400 = Bad Request (invalid input)
  //   401 = Unauthorized (need to log in)
  //   404 = Not Found (URL doesn't exist)
  //   500 = Internal Server Error (server crashed)
  //
  // We throw an Exception so the caller can handle it with try-catch.
  if (response.statusCode != 200) {
    throw Exception('Failed to fetch post: ${response.statusCode}');
  }

  // ============================================================
  // STEP 4: Decode the JSON response
  // ============================================================
  // The response body is a JSON STRING that looks like this:
  //   '{"userId": 1, "id": 1, "title": "...", "body": "..."}'
  //
  // convert.jsonDecode() parses that string into a Dart Map:
  //   {"userId": 1, "id": 1, "title": "...", "body": "..."}
  //
  // We cast it as Map<String, dynamic> because:
  //   - Keys are always Strings (like "title", "userId")
  //   - Values can be different types (String, int, etc.), so we use `dynamic`
  //
  // `dynamic` means "any type" — Dart won't type-check the values at compile time.
  Map<String, dynamic> data =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

  // ============================================================
  // STEP 5: Create a Post object from the Map
  // ============================================================
  // We pull out the fields we need from the Map using bracket notation:
  //   data["title"]  → the post's title (String)
  //   data["userId"] → the post's user ID (int)
  //
  // Then we pass them to the Post constructor to create a typed Dart object.
  // This is called "mapping" or "deserializing" — turning raw data into
  // a structured object that's easier to work with in our code.
  return Post(data["title"], data["userId"]);
}

// =============================================================================
// =============================================================================
//
//  P O S T   C L A S S  (Model / DTO)
//
//  A simple class that represents a blog post from the API.
//  This is called a "model" or "DTO" (Data Transfer Object) —
//  it's a structured container for the data we get from the server.
//
//  The API returns this JSON:
//    {
//      "userId": 1,
//      "id": 1,
//      "title": "sunt aut facere repellat provident...",
//      "body": "quia et suscipit..."
//    }
//
//  We only keep the fields we need: title and userId.
//  (You can add more fields like `id` and `body` if needed.)
//
// =============================================================================
// =============================================================================

class Post {
  // The title of the blog post (from JSON field "title")
  String title;

  // The ID of the user who wrote the post (from JSON field "userId")
  int userId;

  // Constructor — takes title and userId as positional parameters.
  // `this.title` and `this.userId` is Dart shorthand for:
  //   Post(String title, int userId) {
  //     this.title = title;
  //     this.userId = userId;
  //   }
  Post(this.title, this.userId);
}

// =============================================================================
// =============================================================================
//  NOTES: Fetching Data — Summary
// =============================================================================
//
//  PACKAGES USED:
//  ┌────────────────────────┬────────────────────────────────────────────────┐
//  │  Package               │  What it does                                 │
//  ├────────────────────────┼────────────────────────────────────────────────┤
//  │  package:http/http.dart│  Make HTTP requests (GET, POST, PUT, DELETE)  │
//  │  dart:convert          │  Encode/decode JSON (jsonDecode, jsonEncode)  │
//  └────────────────────────┴────────────────────────────────────────────────┘
//
//  KEY CLASSES & METHODS:
//  ┌────────────────────────┬────────────────────────────────────────────────┐
//  │  Class / Method        │  What it does                                 │
//  ├────────────────────────┼────────────────────────────────────────────────┤
//  │  Uri.https()           │  Builds a safe HTTPS URL from parts           │
//  │  http.get()            │  Sends an HTTP GET request (returns Future)   │
//  │  response.statusCode   │  HTTP status code (200 = OK)                  │
//  │  response.body         │  Response body as a String                    │
//  │  jsonDecode()          │  Converts JSON string → Dart Map/List         │
//  │  jsonEncode()          │  Converts Dart Map/List → JSON string         │
//  └────────────────────────┴────────────────────────────────────────────────┘
//
//  FLOW DIAGRAM:
//  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
//  │ Build URL   │ →  │ Send GET    │ →  │ Check       │ →  │ Decode JSON │
//  │ Uri.https() │    │ http.get()  │    │ statusCode  │    │ jsonDecode()│
//  └─────────────┘    └─────────────┘    └─────────────┘    └──────┬──────┘
//                                                                  │
//                                                                  ▼
//                                                           ┌─────────────┐
//                                                           │ Create Post │
//                                                           │ object      │
//                                                           └─────────────┘
//
//  COMMON HTTP METHODS:
//  ┌──────────┬─────────────────────────────────────────────────────────────┐
//  │  Method  │  What it does                                              │
//  ├──────────┼─────────────────────────────────────────────────────────────┤
//  │  GET     │  Fetch/read data (what we used here)                       │
//  │  POST    │  Create new data (send data to the server)                 │
//  │  PUT     │  Update/replace existing data                              │
//  │  PATCH   │  Partially update existing data                            │
//  │  DELETE  │  Delete data                                               │
//  └──────────┴─────────────────────────────────────────────────────────────┘
//
//  TIP: In Flutter apps, you'd call fetchPost() from a widget's initState()
//       or use a FutureBuilder to display the data once it arrives.
// =============================================================================
