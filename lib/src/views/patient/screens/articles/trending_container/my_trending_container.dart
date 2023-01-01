import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/models/article/article.dart';
import 'package:my_health_assistant/src/views/patient/screens/articles/articles_container/article_detail_page.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class MyTrendingContainer extends StatelessWidget {
  const MyTrendingContainer(
      {Key? key, required this.size, required this.article})
      : super(key: key);
  final Size size;
  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ArticleDetailPage(
                      article: article,
                    )));
      }),
      child: Container(
        width: size.width / 2,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: size.width / 2,
                height: size.height / 7,
                child: Image.network(
                  article.imageUrl ??
                      'https://cdn.thuvienphapluat.vn/uploads/tintuc/2022/01/30/cap-nhat-huong-dan-dieu-tri-covid.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              article.title ?? 'Something went wrong',
              style: MyFontStyles.blackColorH3,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
