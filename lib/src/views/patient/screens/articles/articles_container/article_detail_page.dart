import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/models/article/article.dart';
import 'package:my_health_assistant/src/views/patient/screens/articles/articles_container/my_custom_category.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        actions: const [
          'assets/images/schedule_page/search.svg',
          'assets/images/schedule_page/more.svg',
        ],
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
                    article.imageUrl ?? 'https://cdn.thuvienphapluat.vn/uploads/tintuc/2022/01/30/cap-nhat-huong-dan-dieu-tri-covid.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text(
                article.title ?? '',
                style: MyFontStyles.articleTitle,
                textAlign: TextAlign.start,
                maxLines: 2 ,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text(article.time ?? ''),
                  const SizedBox(width: 10,),
                  MyCustomCategory(category: article.category ?? '')
                ],
              ),
              const SizedBox(height: 10,),
              const Divider(color: MyColors.blackText, thickness: 0.5,),
              Text(article.content ?? '', style: MyFontStyles.normalBlackText,)
            ],
          ),
        ),
      ),  
    );
  }
}
