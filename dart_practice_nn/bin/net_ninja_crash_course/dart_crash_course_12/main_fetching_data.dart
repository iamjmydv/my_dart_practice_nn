//------------------------------------------------------------------------------
// F E T C H I N G   D A T A  —  C O M P L E T E   G U I D E
//------------------------------------------------------------------------------
//
// This file combines ALL 10 samples into one runnable file.
// It covers everything about making HTTP requests in Dart —
// from basic GET requests to a full CRUD (Create, Read, Update, Delete) app.
//
// We use the `http` package for HTTP calls and `dart:convert` for JSON.
// API: https://jsonplaceholder.typicode.com (free fake REST API)
//
// Each section has a numbered header, a short description of what it does,
// and a line explaining when/why to use it.
//
// -----------------------------------------------------------------------
//  #  | TOPIC                    | KEY CONCEPTS                              | WHY IT'S USEFUL
// -----------------------------------------------------------------------
//  1  | Basic GET request       | http.get(), Uri.https(), jsonDecode        | Fetch a single item from an API
//  2  | Fetch a list            | JSON arrays, .map(), .toList()             | Fetch multiple items at once
//  3  | Error handling          | try-catch, status codes, network errors    | Prevent crashes when requests fail
//  4  | POST request            | http.post(), jsonEncode, request body      | Send/create new data on the server
//  5  | PUT & PATCH             | http.put(), http.patch(), full vs partial  | Update existing data on the server
//  6  | DELETE request          | http.delete(), status 200/204              | Remove data from the server
//  7  | Query parameters        | Uri.https() 3rd arg, filtering, pagination| Filter and search API data
//  8  | Parallel fetching       | Future.wait() with HTTP calls              | Fetch multiple endpoints at once (fast!)
//  9  | fromJson / toJson       | factory constructors, model pattern         | Professional way to parse/create JSON
// 10  | Real-world CRUD         | Combines ALL concepts                       | How HTTP code looks in production apps
// -----------------------------------------------------------------------
//
// TIP: This file makes REAL HTTP calls — you need internet to run it.
//      To run just ONE sample, comment out the others in main().
//
// -----------------------------------------------------------------------

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() async {
  // ============================================================
  //  Uncomment/comment any sample to run only what you want.
  //  Each sample is independent — they don't depend on each other.
  // ============================================================

  await sample1BasicGet();
  await sample2FetchList();
  await sample3ErrorHandling();
  await sample4PostRequest();
  await sample5PutAndPatch();
  await sample6DeleteRequest();
  await sample7QueryParameters();
  await sample8ParallelFetching();
  await sample9FromJsonToJson();
  await sample10RealWorldCrud();
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  1:  BASIC GET REQUEST — Fetch a Single Item
//
//  The most fundamental HTTP operation.
//  GET = "Give me this data" — you're READING from the server.
//
//  Think of it like looking up a book in a library:
//  You give the librarian a code (URL) → they find the book (server
//  processes request) → they hand it to you (response).
//
//  Flow:
//    1. Build URL with Uri.https()
//    2. Send GET request with http.get()
//    3. Check status code (200 = OK)
//    4. Decode JSON with jsonDecode()
//    5. Create a Dart object from the Map
//
// =============================================================================
// =============================================================================

Future<void> sample1BasicGet() async {
  print('');
  print('##############################################');
  print('# SAMPLE 1: Basic GET Request                #');
  print('##############################################');

  // ============================================================
  // STEP 1: Build the URL
  // ============================================================
  // Uri.https() constructs a proper HTTPS URL from parts:
  //   - 1st arg: the host/domain (WITHOUT https://)
  //   - 2nd arg: the path (starts with /)
  //
  // This creates: https://jsonplaceholder.typicode.com/posts/1
  //
  // Why Uri.https() instead of a plain string?
  //   - Handles special characters automatically
  //   - Validates the URL structure
  //   - Supports query parameters as a 3rd argument
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/1');

  // ============================================================
  // STEP 2: Send the GET request
  // ============================================================
  // http.get() returns a Future<Response>, so we `await` it.
  // The Response object contains:
  //   response.statusCode  → HTTP status (200, 404, 500, etc.)
  //   response.body        → The response body as a String
  //   response.headers     → Response headers from the server
  final response = await http.get(uri, headers: {'Accept': 'application/json'});

  // ============================================================
  // STEP 3: Check if successful
  // ============================================================
  // 200 = OK. Anything else means something went wrong.
  if (response.statusCode != 200) {
    throw Exception('Failed to fetch post: ${response.statusCode}');
  }

  // ============================================================
  // STEP 4: Decode the JSON
  // ============================================================
  // response.body is a JSON STRING like: '{"userId":1,"title":"..."}'
  // jsonDecode() turns it into a Dart Map: {userId: 1, title: "..."}
  //
  // Cast as Map<String, dynamic> because:
  //   - Keys = String ("title", "userId")
  //   - Values = mixed types (String, int, etc.) → dynamic
  Map<String, dynamic> data =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

  // ============================================================
  // STEP 5: Use the data
  // ============================================================
  S1Post post = S1Post(data['title'], data['userId']);
  print('  Title: ${post.title}');
  print('  UserId: ${post.userId}');
  print('');
}

// --- Sample 1: Model ---

class S1Post {
  String title;
  int userId;

  S1Post(this.title, this.userId);
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  2:  FETCH A LIST — Multiple Items from an API
//
//  Most APIs return ARRAYS of data, not just one item.
//  Example: GET /posts returns ALL posts as a JSON array.
//
//  JSON array: [ {post1}, {post2}, {post3}, ... ]
//
//  The key difference from Sample 1:
//    - jsonDecode returns a List<dynamic> (not a Map)
//    - We use .map() to convert each item to a Dart object
//    - We call .toList() to get a proper List<Post>
//
// =============================================================================
// =============================================================================

Future<void> sample2FetchList() async {
  print('##############################################');
  print('# SAMPLE 2: Fetch a List of Items            #');
  print('##############################################');

  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts');
  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed: ${response.statusCode}');
  }

  // ============================================================
  // jsonDecode returns List<dynamic> for JSON arrays
  // Each item is a Map<String, dynamic> (one post)
  // ============================================================
  List<dynamic> jsonList = convert.jsonDecode(response.body);

  // ============================================================
  // .map() transforms each item: Map → S2Post object
  // .toList() converts the Iterable back to a List
  //
  // It's like a conveyor belt:
  //   raw Map in → S2Post object out → collected into a List
  // ============================================================
  List<S2Post> posts = jsonList.map((json) {
    return S2Post(json['id'], json['title'], json['userId']);
  }).toList();

  print('  Total posts fetched: ${posts.length}');
  for (int i = 0; i < 5 && i < posts.length; i++) {
    print('  Post ${posts[i].id}: ${posts[i].title}');
  }
  print('  ... and ${posts.length - 5} more');
  print('');
}

// --- Sample 2: Model ---

class S2Post {
  int id;
  String title;
  int userId;

  S2Post(this.id, this.title, this.userId);
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  3:  ERROR HANDLING — When Requests Go Wrong
//
//  Things that can fail:
//    - Server returns 404 (not found) or 500 (server error)
//    - No internet connection → throws SocketException
//    - Bad JSON in response → throws FormatException
//    - Request takes too long → could use .timeout()
//
//  ALWAYS wrap HTTP calls in try-catch in real apps!
//
//  Common HTTP status codes:
//    200 = OK (success)
//    201 = Created (POST success)
//    400 = Bad Request (your input is wrong)
//    401 = Unauthorized (need to log in)
//    404 = Not Found (URL doesn't exist)
//    500 = Internal Server Error (server crashed)
//
// =============================================================================
// =============================================================================

Future<void> sample3ErrorHandling() async {
  print('##############################################');
  print('# SAMPLE 3: Error Handling                    #');
  print('##############################################');

  // ============================================================
  // 1. SUCCESSFUL REQUEST — Everything works fine
  // ============================================================
  print('  === 1. Successful request ===');
  try {
    var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/1');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed: ${response.statusCode}');
    }

    Map<String, dynamic> data =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    print('  Got post: ${data['title']}');
  } catch (e) {
    print('  Error: $e');
  }

  print('');

  // ============================================================
  // 2. 404 ERROR — Resource doesn't exist
  // ============================================================
  print('  === 2. 404 Not Found ===');
  try {
    var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/99999');
    final response = await http.get(uri);

    if (response.statusCode == 404) {
      throw Exception('Post not found (404)');
    }
    if (response.statusCode != 200) {
      throw Exception('Server error: ${response.statusCode}');
    }

    Map<String, dynamic> data =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    print('  Got post: ${data['title']}');
  } catch (e) {
    print('  Error: $e');
  }

  print('');

  // ============================================================
  // 3. NETWORK ERROR — Bad host, no internet, etc.
  //    http.get() itself throws when it can't connect.
  //    This is different from a bad status code — here the
  //    request never even reaches the server.
  // ============================================================
  print('  === 3. Network error (bad host) ===');
  try {
    var uri = Uri.https('this-server-does-not-exist-12345.com', '/data');
    final response = await http.get(uri);
    print('  Got: ${response.body}');
  } catch (e) {
    print('  Network error caught: $e');
  }

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  4:  POST REQUEST — Sending Data to the Server
//
//  GET = "Give me data" (read)
//  POST = "Here's new data, save it" (create)
//
//  When you submit a form, register an account, or post a comment,
//  that's a POST request — you're SENDING data to the server.
//
//  Key differences from GET:
//    - Include a BODY (the data you're sending)
//    - Set Content-Type header to 'application/json'
//    - Server responds with 201 (Created) instead of 200 (OK)
//    - Use jsonEncode() to convert your Map to a JSON string
//
//  Flow:
//    Map → jsonEncode → JSON string → http.post(body: ...) → server
//
// =============================================================================
// =============================================================================

Future<void> sample4PostRequest() async {
  print('##############################################');
  print('# SAMPLE 4: POST Request (Create)             #');
  print('##############################################');

  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts');

  // ============================================================
  // Build the data we want to send — a regular Dart Map
  // ============================================================
  Map<String, dynamic> newPost = {
    'title': 'My New Post',
    'body': 'This is the content of my post.',
    'userId': 1,
  };

  // ============================================================
  // http.post() — notice the extra parameters:
  //   headers: tells the server we're sending JSON
  //   body: the actual data as a JSON STRING
  //
  // jsonEncode() converts: Map → '{"title":"...","body":"..."}'
  // ============================================================
  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: convert.jsonEncode(newPost),
  );

  // POST returns 201 (Created) on success, not 200
  if (response.statusCode != 201) {
    throw Exception('Failed to create post: ${response.statusCode}');
  }

  // ============================================================
  // The server sends back the created post (with a new ID)
  // ============================================================
  Map<String, dynamic> createdData =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

  print('  Post created!');
  print('  ID: ${createdData['id']}');
  print('  Title: ${createdData['title']}');
  print('  Body: ${createdData['body']}');
  print('  UserId: ${createdData['userId']}');
  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  5:  PUT & PATCH — Updating Data on the Server
//
//  PUT   = "Replace the ENTIRE resource with this new version"
//  PATCH = "Update ONLY the fields I'm sending, keep the rest"
//
//  Think of editing a profile:
//    PUT   = Rewrite the whole profile from scratch
//    PATCH = Just change the email, leave everything else
//
//  Both return 200 (OK) with the updated resource.
//
// =============================================================================
// =============================================================================

Future<void> sample5PutAndPatch() async {
  print('##############################################');
  print('# SAMPLE 5: PUT & PATCH (Update)              #');
  print('##############################################');

  // ============================================================
  // 1. PUT — Replace the ENTIRE resource
  //    Must send ALL fields. If you forget one, it might be removed!
  // ============================================================
  print('  === 1. PUT (full replace) ===');

  var putUri = Uri.https('jsonplaceholder.typicode.com', '/posts/1');
  final putResponse = await http.put(
    putUri,
    headers: {'Content-Type': 'application/json'},
    body: convert.jsonEncode({
      'id': 1,
      'title': 'Completely New Title',
      'body': 'Completely new body content.',
      'userId': 1,
    }),
  );

  if (putResponse.statusCode != 200) {
    throw Exception('PUT failed: ${putResponse.statusCode}');
  }

  Map<String, dynamic> putData =
      convert.jsonDecode(putResponse.body) as Map<String, dynamic>;
  print('  Updated title: ${putData['title']}');
  print('  Updated body: ${putData['body']}');

  print('');

  // ============================================================
  // 2. PATCH — Update ONLY specific fields
  //    The server keeps all other fields as they were.
  // ============================================================
  print('  === 2. PATCH (partial update) ===');

  var patchUri = Uri.https('jsonplaceholder.typicode.com', '/posts/1');
  final patchResponse = await http.patch(
    patchUri,
    headers: {'Content-Type': 'application/json'},
    body: convert.jsonEncode({
      'title': 'Only Title Changed',
      // NOT sending body or userId — they stay the same!
    }),
  );

  if (patchResponse.statusCode != 200) {
    throw Exception('PATCH failed: ${patchResponse.statusCode}');
  }

  Map<String, dynamic> patchData =
      convert.jsonDecode(patchResponse.body) as Map<String, dynamic>;
  print('  Patched title: ${patchData['title']}');
  print('  Body unchanged: ${patchData['body']}');
  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  6:  DELETE REQUEST — Removing Data
//
//  DELETE = "Remove this resource from the server"
//
//  Like deleting a social media post or removing a cart item.
//
//  Key points:
//    - No body needed (just specify WHICH resource to delete via URL)
//    - Server responds with 200 (OK) or 204 (No Content)
//    - The response body is usually empty
//
// =============================================================================
// =============================================================================

Future<void> sample6DeleteRequest() async {
  print('##############################################');
  print('# SAMPLE 6: DELETE Request (Remove)           #');
  print('##############################################');

  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/1');

  // ============================================================
  // http.delete() — just send the URL, no body needed
  // "Delete the resource at this URL"
  // ============================================================
  final response = await http.delete(uri);

  // 200 = OK (deleted, may include deleted data in response)
  // 204 = No Content (deleted, nothing sent back)
  if (response.statusCode == 200 || response.statusCode == 204) {
    print('  Post #1 deleted successfully!');
    print('  Status code: ${response.statusCode}');
  } else {
    print('  Failed to delete: ${response.statusCode}');
  }

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  7:  QUERY PARAMETERS — Filtering & Searching
//
//  Query params are the ?key=value parts at the end of a URL:
//    /posts?userId=1       → only posts by user 1
//    /comments?postId=1    → only comments on post 1
//    /posts?_limit=5       → only the first 5 posts
//
//  Uri.https() has a 3rd argument for query params — a Map<String, String>.
//  It automatically adds the ? and & for you.
//
//  IMPORTANT: Query param values must be STRINGS (not int or bool).
//  Use .toString() to convert numbers.
//
// =============================================================================
// =============================================================================

Future<void> sample7QueryParameters() async {
  print('##############################################');
  print('# SAMPLE 7: Query Parameters                  #');
  print('##############################################');

  // ============================================================
  // 1. FILTER — Get posts by a specific user
  //    Uri.https('host', '/path', {'key': 'value'})
  //    → https://host/path?key=value
  // ============================================================
  print('  === 1. Filter by userId ===');

  var uri1 = Uri.https('jsonplaceholder.typicode.com', '/posts', {
    'userId': '1', // values must be String
  });
  // Builds: https://jsonplaceholder.typicode.com/posts?userId=1

  final response1 = await http.get(uri1);
  List posts = convert.jsonDecode(response1.body) as List;
  print('  Posts by user #1: ${posts.length}');

  print('');

  // ============================================================
  // 2. RELATED RESOURCE — Get comments for a post
  // ============================================================
  print('  === 2. Comments for post #1 ===');

  var uri2 = Uri.https('jsonplaceholder.typicode.com', '/comments', {
    'postId': '1',
  });

  final response2 = await http.get(uri2);
  List comments = convert.jsonDecode(response2.body) as List;
  print('  Comments on post #1: ${comments.length}');
  if (comments.isNotEmpty) {
    print('  First comment by: ${comments[0]['email']}');
  }

  print('');

  // ============================================================
  // 3. PAGINATION — Limit and offset results
  //    Multiple params are joined with & automatically:
  //    /posts?_start=3&_limit=3
  // ============================================================
  print('  === 3. Pagination (page 2, 3 per page) ===');

  int page = 2;
  int perPage = 3;
  int start = (page - 1) * perPage;

  var uri3 = Uri.https('jsonplaceholder.typicode.com', '/posts', {
    '_start': start.toString(),
    '_limit': perPage.toString(),
  });

  final response3 = await http.get(uri3);
  List paged = convert.jsonDecode(response3.body) as List;
  for (var post in paged) {
    print('  Post ${post['id']}: ${post['title']}');
  }

  print('');
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  8:  PARALLEL FETCHING — Multiple Endpoints at Once
//
//  Often you need data from SEVERAL endpoints.
//  Example: A profile page needs the user, their posts, AND their albums.
//
//  SLOW way: await user → await posts → await albums (sequential)
//  FAST way: Future.wait([user, posts, albums]) (all at once!)
//
//  Future.wait() starts all HTTP calls simultaneously and waits
//  for ALL to finish. Total time = slowest call (not sum of all).
//
// =============================================================================
// =============================================================================

Future<void> sample8ParallelFetching() async {
  print('##############################################');
  print('# SAMPLE 8: Parallel Fetching                 #');
  print('##############################################');

  int userId = 1;

  Stopwatch sw = Stopwatch()..start();

  // ============================================================
  // Future.wait() runs all 3 HTTP calls at the SAME TIME
  // ============================================================
  var results = await Future.wait([
    s8FetchUser(userId),
    s8FetchUserPosts(userId),
    s8FetchUserAlbums(userId),
  ]);

  sw.stop();

  Map<String, dynamic> user = results[0] as Map<String, dynamic>;
  List userPosts = results[1] as List;
  List userAlbums = results[2] as List;

  print('  User: ${user['name']} (${user['email']})');
  print('  Posts: ${userPosts.length} posts');
  print('  Albums: ${userAlbums.length} albums');
  print('  Time: ${sw.elapsed.inMilliseconds}ms');
  print('  (All 3 ran at the same time — much faster than one by one!)');
  print('');
}

// --- Sample 8: Helper functions ---

Future<Map<String, dynamic>> s8FetchUser(int userId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/users/$userId');
  final response = await http.get(uri);
  if (response.statusCode != 200) {
    throw Exception('Failed to fetch user: ${response.statusCode}');
  }
  return convert.jsonDecode(response.body) as Map<String, dynamic>;
}

Future<List> s8FetchUserPosts(int userId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts', {
    'userId': userId.toString(),
  });
  final response = await http.get(uri);
  if (response.statusCode != 200) {
    throw Exception('Failed to fetch posts: ${response.statusCode}');
  }
  return convert.jsonDecode(response.body) as List;
}

Future<List> s8FetchUserAlbums(int userId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/albums', {
    'userId': userId.toString(),
  });
  final response = await http.get(uri);
  if (response.statusCode != 200) {
    throw Exception('Failed to fetch albums: ${response.statusCode}');
  }
  return convert.jsonDecode(response.body) as List;
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  9:  fromJson / toJson — The Professional Model Pattern
//
//  In samples 1-8 we manually pulled fields from Maps:
//    Post(data['title'], data['userId'])
//
//  In real apps, you use factory constructors:
//    Post.fromJson(data)    → JSON Map → Dart object (deserialization)
//    post.toJson()          → Dart object → JSON Map (serialization)
//
//  Why this pattern?
//    - Keeps parsing logic INSIDE the class (not scattered everywhere)
//    - Easy to reuse — call User.fromJson() from any file
//    - Easy to test — one place to check for bugs
//    - Standard convention in Flutter/Dart projects
//
//  Flow:
//    JSON string → jsonDecode → Map → fromJson → Dart object
//    Dart object → toJson → Map → jsonEncode → JSON string
//
// =============================================================================
// =============================================================================

Future<void> sample9FromJsonToJson() async {
  print('##############################################');
  print('# SAMPLE 9: fromJson / toJson Model Pattern   #');
  print('##############################################');

  // ============================================================
  // 1. FETCH & PARSE with fromJson
  //    Instead of: User(data['name'], data['email'])
  //    We do:      User.fromJson(data)
  // ============================================================
  print('  === 1. fromJson — Parse API data ===');

  var uri = Uri.https('jsonplaceholder.typicode.com', '/users/1');
  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed: ${response.statusCode}');
  }

  Map<String, dynamic> data =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

  // One clean call — all parsing logic is inside the class
  S9User user = S9User.fromJson(data);
  print('  Name: ${user.name}');
  print('  Email: ${user.email}');
  print('  Phone: ${user.phone}');

  print('');

  // ============================================================
  // 2. CONVERT BACK with toJson
  //    User → Map → ready for jsonEncode() to send to server
  // ============================================================
  print('  === 2. toJson — Convert back to Map ===');
  Map<String, dynamic> json = user.toJson();
  print('  Map: $json');

  print('');

  // ============================================================
  // 3. FULL ROUND-TRIP: object → JSON string → object
  //    This is what happens when you send data to a server
  //    and then read the response.
  // ============================================================
  print('  === 3. Full round-trip ===');
  String jsonString = convert.jsonEncode(user.toJson());
  print('  JSON string: $jsonString');

  // Parse it back (simulating reading a response)
  Map<String, dynamic> parsed =
      convert.jsonDecode(jsonString) as Map<String, dynamic>;
  S9User rebuilt = S9User.fromJson(parsed);
  print('  Rebuilt: ${rebuilt.name} (${rebuilt.email})');

  print('');
}

// --- Sample 9: Model with fromJson/toJson ---

class S9User {
  int id;
  String name;
  String email;
  String phone;

  S9User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  // factory constructor: Map → S9User
  // "factory" means it can do work before creating the instance.
  // Reads specific keys from the JSON Map and passes them to the constructor.
  factory S9User.fromJson(Map<String, dynamic> json) {
    return S9User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  // Convert: S9User → Map
  // This Map can then be passed to jsonEncode() to get a JSON string.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}

// =============================================================================
// =============================================================================
//
//  S A M P L E  10:  REAL-WORLD CRUD PATTERN — Full Workflow
//
//  This sample puts EVERYTHING together in a realistic scenario.
//  It simulates a mini app that performs all CRUD operations:
//
//    C = Create (POST)  — Add a new post
//    R = Read   (GET)   — Fetch a single post & a list of posts
//    U = Update (PUT)   — Modify an existing post
//    D = Delete (DELETE) — Remove a post
//
//  Uses: http.get/post/put/delete, fromJson/toJson, query params,
//        try-catch-finally, and proper error handling.
//
// =============================================================================
// =============================================================================

Future<void> sample10RealWorldCrud() async {
  print('##############################################');
  print('# SAMPLE 10: Real-World CRUD Pattern          #');
  print('##############################################');
  print('');
  print('  ========================================');
  print('    MINI CRUD APP');
  print('  ========================================');
  print('');

  bool isLoading = true;

  try {
    // --- CREATE — POST request ---
    print('  [1/5] CREATE — Adding a new post...');
    S10Post created = await s10CreatePost(S10Post(
      id: 0,
      title: 'My New Post',
      body: 'Hello from Dart!',
      userId: 1,
    ));
    print('        Created post with ID: ${created.id}');
    print('');

    // --- READ ONE — GET request ---
    print('  [2/5] READ — Fetching post #1...');
    S10Post post = await s10GetPost(1);
    print('        Title: ${post.title}');
    print('');

    // --- READ MANY — GET with query params ---
    print('  [3/5] READ LIST — Posts by user #1...');
    List<S10Post> userPosts = await s10GetPostsByUser(1);
    print('        Found ${userPosts.length} posts');
    print('');

    // --- UPDATE — PUT request ---
    print('  [4/5] UPDATE — Changing the title...');
    post.title = 'Updated: ${post.title}';
    S10Post updated = await s10UpdatePost(post);
    print('        New title: ${updated.title}');
    print('');

    // --- DELETE — DELETE request ---
    print('  [5/5] DELETE — Removing post #1...');
    bool deleted = await s10DeletePost(1);
    print('        Deleted: $deleted');
  } catch (e) {
    print('');
    print('  ERROR: $e');
    print('  Please try again later.');
  } finally {
    isLoading = false;
    print('');
    print('  (Loading complete. isLoading = $isLoading)');
    print('  ========================================');
  }

  print('');
}

// --- Sample 10: Model ---

class S10Post {
  int id;
  String title;
  String body;
  int userId;

  S10Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory S10Post.fromJson(Map<String, dynamic> json) {
    return S10Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
    };
  }
}

// --- Sample 10: CRUD Functions ---

Future<S10Post> s10CreatePost(S10Post post) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts');
  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: convert.jsonEncode(post.toJson()),
  );
  if (response.statusCode != 201) {
    throw Exception('Failed to create: ${response.statusCode}');
  }
  return S10Post.fromJson(
      convert.jsonDecode(response.body) as Map<String, dynamic>);
}

Future<S10Post> s10GetPost(int postId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/$postId');
  final response = await http.get(uri);
  if (response.statusCode != 200) {
    throw Exception('Failed to fetch: ${response.statusCode}');
  }
  return S10Post.fromJson(
      convert.jsonDecode(response.body) as Map<String, dynamic>);
}

Future<List<S10Post>> s10GetPostsByUser(int userId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts', {
    'userId': userId.toString(),
  });
  final response = await http.get(uri);
  if (response.statusCode != 200) {
    throw Exception('Failed to fetch: ${response.statusCode}');
  }
  List<dynamic> jsonList = convert.jsonDecode(response.body);
  return jsonList.map((json) => S10Post.fromJson(json)).toList();
}

Future<S10Post> s10UpdatePost(S10Post post) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/${post.id}');
  final response = await http.put(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: convert.jsonEncode(post.toJson()),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to update: ${response.statusCode}');
  }
  return S10Post.fromJson(
      convert.jsonDecode(response.body) as Map<String, dynamic>);
}

Future<bool> s10DeletePost(int postId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/$postId');
  final response = await http.delete(uri);
  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception('Failed to delete: ${response.statusCode}');
  }
  return true;
}

// =============================================================================
// =============================================================================
//  NOTES: Fetching Data — Complete Summary of ALL 10 Samples
// =============================================================================
//
//  -----------------------------------------------------------------------
//   #  | TOPIC                    | KEY CONCEPTS
//  -----------------------------------------------------------------------
//   1  | Basic GET request       | http.get(), Uri.https(), jsonDecode
//   2  | Fetch a list            | JSON arrays, .map(), .toList()
//   3  | Error handling          | try-catch, status codes, network errors
//   4  | POST request            | http.post(), jsonEncode, request body
//   5  | PUT & PATCH             | http.put(), http.patch(), full vs partial
//   6  | DELETE request          | http.delete(), status 200/204
//   7  | Query parameters        | Uri.https() 3rd arg, filtering, pagination
//   8  | Parallel fetching       | Future.wait() with real HTTP calls
//   9  | fromJson / toJson       | factory constructors, model pattern
//  10  | Real-world CRUD         | Combines ALL concepts
//  -----------------------------------------------------------------------
//
//  HTTP METHODS — CRUD Mapping:
//  ┌──────────┬──────────────┬────────────────────────────────────────────┐
//  │  CRUD    │  HTTP Method  │  What it does                             │
//  ├──────────┼──────────────┼────────────────────────────────────────────┤
//  │  Create  │  POST         │  Send new data to the server              │
//  │  Read    │  GET          │  Fetch/retrieve data from the server      │
//  │  Update  │  PUT / PATCH  │  Modify existing data on the server       │
//  │  Delete  │  DELETE       │  Remove data from the server              │
//  └──────────┴──────────────┴────────────────────────────────────────────┘
//
//  KEY CLASSES & METHODS:
//  ┌────────────────────────────┬────────────────────────────────────────────┐
//  │  Class / Method            │  What it does                             │
//  ├────────────────────────────┼────────────────────────────────────────────┤
//  │  Uri.https(host, path)     │  Build a safe HTTPS URL                   │
//  │  Uri.https(h, p, params)   │  URL with query parameters (?key=value)   │
//  │  http.get(uri)             │  Send GET request (read)                  │
//  │  http.post(uri, body:)     │  Send POST request (create)               │
//  │  http.put(uri, body:)      │  Send PUT request (full update)           │
//  │  http.patch(uri, body:)    │  Send PATCH request (partial update)      │
//  │  http.delete(uri)          │  Send DELETE request (remove)             │
//  │  jsonDecode(string)        │  JSON string → Dart Map/List              │
//  │  jsonEncode(map)           │  Dart Map/List → JSON string              │
//  │  response.statusCode       │  HTTP status (200, 201, 404, 500, etc.)   │
//  │  response.body             │  Response body as a String                │
//  │  Model.fromJson(map)       │  Factory: Map → Dart object               │
//  │  model.toJson()            │  Method: Dart object → Map                │
//  └────────────────────────────┴────────────────────────────────────────────┘
//
//  COMMON STATUS CODES:
//  ┌────────┬─────────────────────────────────────────────────────────────┐
//  │  Code  │  Meaning                                                   │
//  ├────────┼─────────────────────────────────────────────────────────────┤
//  │  200   │  OK — Request succeeded                                    │
//  │  201   │  Created — POST succeeded, new resource created            │
//  │  204   │  No Content — DELETE succeeded, nothing to return          │
//  │  400   │  Bad Request — Invalid input / malformed request           │
//  │  401   │  Unauthorized — Need to log in / bad credentials           │
//  │  403   │  Forbidden — Logged in but not allowed                     │
//  │  404   │  Not Found — Resource doesn't exist                        │
//  │  500   │  Internal Server Error — Server crashed                    │
//  └────────┴─────────────────────────────────────────────────────────────┘
//
//  REAL-WORLD PATTERN:
//  ┌──────────────────────────────────────────────┐
//  │  1. Build URL (Uri.https)                    │
//  │  2. try {                                    │
//  │       final response = await http.get(url);  │
//  │       check statusCode                       │
//  │       jsonDecode response.body               │
//  │       Model.fromJson(data)                   │
//  │     } catch (e) {                            │
//  │       handle error                           │
//  │     }                                        │
//  └──────────────────────────────────────────────┘
//
//  PACKAGES NEEDED (pubspec.yaml):
//    dependencies:
//      http: ^1.6.0
//
//  IMPORTS NEEDED:
//    import 'package:http/http.dart' as http;
//    import 'dart:convert' as convert;
//
// =============================================================================
