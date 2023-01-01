import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/models/article/article.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

class ArticleDetail extends StatelessWidget {
  const ArticleDetail({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  child: Image.network(
                    article.imageUrl ?? 'https://res.edu.vn/wp-content/uploads/2021/12/unit-10-health-res-english.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                article.title ?? '',
                style: MyFontStyles.articleTitle,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(article.time ?? ''),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: MyColors.lightBlue,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      article.category!,
                      style: MyFontStyles.mainColorH5,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: MyColors.blackText,
                thickness: 0.5,
              ),
              Text(
                article.content ?? '',
                style: MyFontStyles.normalBlackText,
              )
            ],
          ),
        ),
      ),
    );
  }
}
