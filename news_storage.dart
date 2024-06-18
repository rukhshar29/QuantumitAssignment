import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveNews(List<dynamic> news) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonNews = jsonEncode(news); 
    await prefs.setString('newsData', jsonNews); 
  }

  static Future<List<dynamic>> getNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? newsData = prefs.getString('newsData'); 
    if (newsData != null) {
      List<dynamic> newsList = jsonDecode(newsData); 
      return newsList;
    } else {
      return []; 
    }
  }
}
