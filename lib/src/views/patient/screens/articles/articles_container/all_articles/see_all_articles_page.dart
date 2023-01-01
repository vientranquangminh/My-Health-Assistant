import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/models/article/article.dart';
import 'package:my_health_assistant/src/views/patient/screens/articles/articles_container/all_articles/my_list_articles.dart';
import 'package:my_health_assistant/src/views/patient/screens/home/component/title_tabbar.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

class SeeAllArticlesPage extends StatefulWidget {
  const SeeAllArticlesPage({Key? key, required this.covid19Category, required this.healthCategory, required this.lifestyleCategory, required this.medicalCategory}) : super(key: key);
  final List<Article> medicalCategory;
  final List<Article> healthCategory;
  final List<Article> covid19Category;
  final List<Article> lifestyleCategory;

  @override
  State<SeeAllArticlesPage> createState() => _SeeAllArticlesPageState();
}

class _SeeAllArticlesPageState extends State<SeeAllArticlesPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Articles',
          actions: const [
            'assets/images/schedule_page/search.svg',
            'assets/images/schedule_page/more.svg',
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              SizedBox(
                height: 30,
                child: TabBar(
                  controller: tabController,
                  labelColor: MyColors.whiteText,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: MyColors.blackText,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: MyColors.mainColor),
                  tabs: const [
                    TabbarTitle(title: 'Medical'),
                    TabbarTitle(title: 'Health'),
                    TabbarTitle(title: 'Covid-19'),
                    TabbarTitle(title: 'Lifestyle'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    MyListArticles(articles: widget.medicalCategory,),
                    MyListArticles(articles: widget.healthCategory,),
                    MyListArticles(articles: widget.covid19Category,),
                    MyListArticles(articles: widget.lifestyleCategory,),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
