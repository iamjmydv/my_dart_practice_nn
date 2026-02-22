import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() async {
  final post = await fetchPost();
  print('Title: ${post.title}');
  print('UserId: ${post.userId}');
}

Future<Post> fetchPost() async {
  var uri = Uri.https('jsonplaceholder.typicode.com', '/posts/1');

  final response = await http.get(uri, headers: {'Accept': 'application/json'});

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch post: ${response.statusCode}');
  }

  Map<String, dynamic> data = convert.jsonDecode(response.body) as Map<String, dynamic>;

  return Post(data["title"], data["userId"]);
}

class Post {
  String title;
  int userId;

  Post(this.title, this.userId);
}
