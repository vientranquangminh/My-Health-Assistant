import 'package:flutter/cupertino.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          children: [
            Image.asset('assets/images/home_page/not_found.png'),
            const SizedBox(height: 16),
            Text(
              'Not Found',
              style: MyFontStyles.blackColorH1.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 16),
            Text(
              'Sorry, the keyword you entered cannot be found, please check again or search with another keyword.',
              textAlign: TextAlign.center,
              style: MyFontStyles.normalBlackText.copyWith(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
