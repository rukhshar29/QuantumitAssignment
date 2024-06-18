import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String publishedAt;
  final String source;
  final String imageUrl;

  NewsCard({required this.title, required this.description, required this.publishedAt, required this.source, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 10),
                  Text('Source: $source'),
                  Text('Published at: $publishedAt'),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: imageUrl != null ? Image.network(imageUrl, fit: BoxFit.cover) : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
