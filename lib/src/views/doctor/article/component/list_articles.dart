import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/models/article/article.dart';
import 'package:my_health_assistant/src/views/doctor/article/component/article_container.dart';
import 'package:my_health_assistant/src/views/doctor/article/component/article_detail.dart';

class ListArticles extends StatelessWidget {
  const ListArticles({Key? key, required this.articles}) : super(key: key);
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ArticleDetail(
                              article: articles[index],
                            )));
              }),
              child: ArticleContainer(
                imgUrl: articles[index].imageUrl ??
                    'https://res.edu.vn/wp-content/uploads/2021/12/unit-10-health-res-english.jpg',
                time: articles[index].time ?? '',
                title: articles[index].title ?? '',
                category: articles[index].category ?? '',
              ),
            );
          }),
    );
  }
}
