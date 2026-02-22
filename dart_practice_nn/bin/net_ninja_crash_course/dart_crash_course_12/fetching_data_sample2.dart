//------------------------------------------------------------------------------
// F E T C H I N G   D A T A  —  S A M P L E  2
//------------------------------------------------------------------------------
//
// TOPIC: Fetching a LIST of items from the API
//
// Sample 1 fetched ONE post. But APIs usually return MANY items.
// This sample fetches ALL posts (a JSON array) and turns them
// into a List<Post> in Dart.
//
// JSON array looks like:
//   [ {"userId":1, "id":1, "title":"..."}, {"userId":1, "id":2, "title":"..."}, ... ]
//
// API: https://jsonplaceholder.typicode.com/posts  (returns 100 posts)
//
//------------------------------------------------------------------------------

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() async {
  List<Post> posts = await fetchAllPosts();

  print('Total posts fetched: ${posts.length}');
  print('');

  // Print the first 5 posts
  for (int i = 0; i < 5 && i < posts.length; i++) {
    print('Post ${posts[i].id}: ${posts[i].title}');
  }
  print('... and ${posts.length - 5} more');
}

// =============================================================================
//  Fetch ALL posts — returns a List<Post>
// =============================================================================
//
// The API returns a JSON ARRAY (a list), not a single object.
// So we decode it as a List<dynamic>, then .map() each item to a Post.
//
// Flow:
//   1. GET /posts → JSON array string
//   2. jsonDecode → List<dynamic>
//   3. .map() each item → Post object
//   4. .toList() → List<Post>
//
Future<List<Post>> fetchAllPosts() async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts');
  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch posts: ${response.statusCode}');
  }

  // jsonDecode returns a List<dynamic> for JSON arrays.
  // Each item in the list is a Map<String, dynamic> (one post).
  List<dynamic> jsonList = convert.jsonDecode(response.body);

  // .map() transforms every item in the list, like a conveyor belt:
  //   raw JSON map in → Post object out
  List<Post> posts = jsonList.map((json) {
    return Post(json['id'], json['title'], json['userId']);
  }).toList();

  return posts;
}

class Post {
  int id;
  String title;
  int userId;

  Post(this.id, this.title, this.userId);
}
