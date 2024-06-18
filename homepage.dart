import 'package:demo/project2/loginpage.dart';
import 'package:demo/project2/new_card.dart';
import 'package:demo/project2/news_service.dart';
import 'package:demo/project2/news_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';





class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _news = [];

  List<dynamic> _filteredNews = [];

  bool _isLoading = true;

  TextEditingController _searchController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _logout() async {
    await _auth.signOut();
  }

   @override
  void initState() {
    super.initState();
    _fetchNews();
    _searchController.addListener(_filterNews);
  }

  Future<void> _fetchNews() async {
    try {
      _news = await NewsService.fetchNews();
      await LocalStorage.saveNews(_news);
    } catch (e) {
      _news = await LocalStorage.getNews();
    }
    setState(() {
      _filteredNews = _news;
      _isLoading = false;
    });
  }

  void _filterNews() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredNews = _news.where((article) {
        return article['title'].toLowerCase().contains(query) ||
               article['description'].toLowerCase().contains(query) ||
               article['source']['name'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Loginpageee()),
              );
            },
          ),
        ],
      ),
            body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredNews.length,
                    itemBuilder: (context, index) {
                      var article = _filteredNews[index];
                      return NewsCard(
                        title: article['title'],
                        description: article['description'],
                        publishedAt: article['publishedAt'],
                        source: article['source']['name'],
                        imageUrl: article['urlToImage'],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

   