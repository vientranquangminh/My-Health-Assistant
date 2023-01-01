import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer(
      {Key? key,
      required this.time,
      required this.title,
      required this.category,
      required this.imgUrl})
      : super(key: key);
  final String time;
  final String title;
  final String category;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox.fromSize(
              size: const Size.fromRadius(48),
              child: Image.network(imgUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style:
                      const TextStyle(fontSize: 10, color: MyColors.greyText),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: MyFontStyles.blackColorH3,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: MyColors.lightBlue,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text(
                    category,
                    style: MyFontStyles.mainColorH5,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
