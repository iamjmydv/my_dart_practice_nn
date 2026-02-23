import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  fetchData();
}

Future<void> fetchData() async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print('USER ID: ${data['userId']}');
      print('TITLE: ${data['title']}');
      print('BODY: ${data['body']}');
    }
  } catch (e) {
    print('Invalid get request $e');
  }
}

