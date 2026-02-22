//------------------------------------------------------------------------------
// F E T C H I N G   D A T A  —  S A M P L E  10
//------------------------------------------------------------------------------
//
// TOPIC: Real-World Pattern — Full CRUD with Proper Error Handling
//
// This sample combines EVERYTHING from samples 1-9:
//   - GET (read), POST (create), PUT (update), DELETE (remove)
//   - fromJson / toJson model pattern
//   - Error handling with try-catch
//   - Query parameters
//   - Parallel fetching
//
// CRUD = Create, Read, Update, Delete
// These are the 4 basic operations for any data-driven app.
//
// API: https://jsonplaceholder.typicode.com/posts
//
//------------------------------------------------------------------------------

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() async {
  print('========================================');
  print('  CRUD DEMO — Full Workflow');
  print('========================================');
  print('');

  try {
    // === CREATE — Add a new post ===
    print('[1/5] CREATE — Adding a new post...');
    Post created = await createPost(
      Post(id: 0, title: 'My New Post', body: 'Hello from Dart!', userId: 1),
    );
    print('      Created post with ID: ${created.id}');
    print('');

    // === READ ONE — Fetch a single post ===
    print('[2/5] READ — Fetching post #1...');
    Post post = await getPost(1);
    print('      Title: ${post.title}');
    print('');

    // === READ MANY — Fetch posts by user ===
    print('[3/5] READ LIST — Fetching posts by user #1...');
    List<Post> userPosts = await getPostsByUser(1);
    print('      Found ${userPosts.length} posts');
    print('');

    // === UPDATE — Modify the post ===
    print('[4/5] UPDATE — Changing the title...');
    post.title = 'Updated: ${post.title}';
    Post updated = await updatePost(post);
    print('      New title: ${updated.title}');
    print('');

    // === DELETE — Remove the post ===
    print('[5/5] DELETE — Removing post #1...');
    bool deleted = await deletePost(1);
    print('      Deleted: $deleted');
  } catch (e) {
    print('');
    print('ERROR: $e');
  }

  print('');
  print('========================================');
  print('  CRUD Demo Complete!');
  print('========================================');
}

// =============================================================================
//  Post Model — with fromJson & toJson
// =============================================================================

class Post {
  int id;
  String title;
  String body;
  int userId;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
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

// =============================================================================
//  CRUD Functions — Create, Read, Update, Delete
// =============================================================================

// CREATE — POST request
Future<Post> createPost(Post post) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts');

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: convert.jsonEncode(post.toJson()),
  );

  if (response.statusCode != 201) {
    throw Exception('Failed to create: ${response.statusCode}');
  }

  return Post.fromJson(
      convert.jsonDecode(response.body) as Map<String, dynamic>);
}

// READ ONE — GET request
Future<Post> getPost(int postId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/$postId');
  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch: ${response.statusCode}');
  }

  return Post.fromJson(
      convert.jsonDecode(response.body) as Map<String, dynamic>);
}

// READ MANY — GET with query params
Future<List<Post>> getPostsByUser(int userId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts', {
    'userId': userId.toString(),
  });
  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch: ${response.statusCode}');
  }

  List<dynamic> jsonList = convert.jsonDecode(response.body);
  return jsonList.map((json) => Post.fromJson(json)).toList();
}

// UPDATE — PUT request
Future<Post> updatePost(Post post) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/${post.id}');

  final response = await http.put(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: convert.jsonEncode(post.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update: ${response.statusCode}');
  }

  return Post.fromJson(
      convert.jsonDecode(response.body) as Map<String, dynamic>);
}

// DELETE — DELETE request
Future<bool> deletePost(int postId) async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/$postId');
  final response = await http.delete(uri);

  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception('Failed to delete: ${response.statusCode}');
  }

  return true;
}
