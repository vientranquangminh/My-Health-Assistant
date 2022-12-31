import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class DialogWaitingBuilder extends StatelessWidget {
  const DialogWaitingBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: SizedBox(
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/sign_in/conratulation.png'),
              Text(
                'Successful!',
                style: MyFontStyles.mainColorH1.copyWith(fontSize: 25),
              ),
              Text(
                'You are sign in successful. You will be redirected to the Home page in a few seconds',
                textAlign: TextAlign.center,
                style: MyFontStyles.blackColorH1
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 80,
                height: 80,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  strokeWidth: 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
