// https://jsonplaceholder.typicode.com/posts/2

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  final post = await fetchData();
  print('User ID: ${post.userId}');
  print('Title: ${post.title}');
  print('Body: ${post.body}');
}

Future<Post> fetchData() async {
  final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts/2");

  try {
    final response = await http.get(uri, headers: {'accept': 'application/json'});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return Post(
        userId: data["userId"],
        title: data["title"],
        body: data["body"],
      );
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Invalid response: $e');
  }
}

class Post {
  final int userId;
  final String title;
  final String body;

  Post({required this.userId, required this.title, required this.body});
}
