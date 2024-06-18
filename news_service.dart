
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const _apiKey = 'a905e3f4bde24a6e98f867f696e64a90';

  static const _baseUrl = 'https://newsapi.org/v2/everything?q=tesla&from=2024-05-18&sortBy=publishedAt&apiKey=a905e3f4bde24a6e98f867f696e64a90';


  static Future<List<dynamic>> fetchNews() async {
    final response = await http.get(Uri.parse('$_baseUrl?country=us&apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
