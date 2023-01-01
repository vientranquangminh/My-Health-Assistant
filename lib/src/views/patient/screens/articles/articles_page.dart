import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_health_assistant/src/controllers/article_controller/article_controller.dart';
import 'package:my_health_assistant/src/models/article/article.dart';
import 'package:my_health_assistant/src/views/patient/screens/articles/articles_container/all_articles/see_all_articles_page.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_text_button.dart';

import '../home/component/title_tabbar.dart';
import 'articles_container/all_articles/my_list_articles.dart';
import 'trending_container/my_trending_container.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors.whiteText,
          elevation: 0.0,
          leading: SvgPicture.asset('assets/images/main_icon.svg',
              color: Colors.blue),
          title: const Text(
            "Articles",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon:
                    SvgPicture.asset('assets/images/schedule_page/search.svg'),
                color: Colors.black),
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/images/schedule_page/more.svg'),
                color: Colors.black)
          ]),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: size.height,
          width: size.width,
          child: StreamBuilder<List<Article>>(
              stream: ArticleController.getAllArticles(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  List<Article> articles = snapshot.data!;
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Trending',
                              style: MyFontStyles.blackColorH1,
                            ),
                            MyTextButton(
                                buttonColor: Colors.transparent,
                                textColor: MyColors.mainColor,
                                text: 'See All',
                                fontSize: 14,
                                customFunction: (() {
                                  log('See All');
                                }))
                          ],
                        ),
                        SizedBox(
                          height: size.height / 5,
                          width: size.width,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: articles.length,
                              itemBuilder: (context, index) {
                                return MyTrendingContainer(
                                  size: size,
                                  article: articles[index],
                                );
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Articles',
                              style: MyFontStyles.blackColorH1,
                            ),
                            MyTextButton(
                                buttonColor: Colors.transparent,
                                textColor: MyColors.mainColor,
                                text: 'See All',
                                fontSize: 14,
                                customFunction: (() {
                                  log('See All');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => SeeAllArticlesPage(
                                              covid19Category: ArticleController
                                                  .getArticlesByCategory(
                                                      articles, 'Covid-19'),
                                              healthCategory:
                                                  ArticleController.getArticlesByCategory(
                                                      articles, 'Health'),
                                              lifestyleCategory:
                                                  ArticleController.getArticlesByCategory(
                                                      articles, 'Lifestyle'),
                                              medicalCategory: ArticleController
                                                  .getArticlesByCategory(
                                                      articles, 'Medical')))));
                                }))
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          child: TabBar(
                            controller: tabController,
                            labelColor: MyColors.whiteText,
                            isScrollable: true,
                            unselectedLabelColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 6),
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
                              MyListArticles(
                                articles:
                                    ArticleController.getArticlesByCategory(
                                        articles, 'Medical'),
                              ),
                              MyListArticles(
                                articles:
                                    ArticleController.getArticlesByCategory(
                                        articles, 'Health'),
                              ),
                              MyListArticles(
                                articles:
                                    ArticleController.getArticlesByCategory(
                                        articles, 'Covid-19'),
                              ),
                              MyListArticles(
                                articles:
                                    ArticleController.getArticlesByCategory(
                                        articles, 'Lifestyle'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              })),
    );
  }
}
