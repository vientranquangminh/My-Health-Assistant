import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/models/article/article.dart';
import 'package:my_health_assistant/src/views/patient/screens/articles/articles_container/article_detail_page.dart';
import '../my_articles_container.dart';

class MyListArticles extends StatelessWidget {
  const MyListArticles({Key? key, required this.articles}) : super(key: key);
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (() {
            log('navigating to ${articles[index].category} - index: $index - page');
            Navigator.push(context, MaterialPageRoute(builder: (_) => ArticleDetailPage(article: articles[index],)));
          }),
          child: MyArticleContainer(
            imgUrl: articles[index].imageUrl ?? 'https://cdn.thuvienphapluat.vn/uploads/tintuc/2022/01/30/cap-nhat-huong-dan-dieu-tri-covid.jpg',
            time: articles[index].time ?? '',
            title:
                articles[index].title ?? '',
            category: articles[index].category ?? '',
          ),
        );
      }
    );
  }
}
