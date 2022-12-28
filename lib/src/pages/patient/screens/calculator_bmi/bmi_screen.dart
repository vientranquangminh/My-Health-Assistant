import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import 'component/age_weight_widget.dart';
import 'component/gender_widget.dart';
import 'component/height_widget.dart';
import 'component/score_screen.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({Key? key}) : super(key: key);

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  int _gender = 0;
  int _height = 150;
  int _age = 30;
  int _weight = 50;
  bool _isFinished = false;
  double _bmiScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 100, 199, 238),
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: const Text(
              'BMI Calculator',
              style: TextStyle(color: Colors.black),
            )),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  GenderWidget(
                    onChange: (genderVal) {
                      _gender = genderVal;
                    },
                  ),
                  HeightWidget(
                    onChange: (heightVal) {
                      _height = heightVal;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AgeWeightWidget(
                          onChange: (ageVal) {
                            _age = ageVal;
                          },
                          title: "Age",
                          initValue: 30,
                          min: 18,
                          max: 65),
                      AgeWeightWidget(
                          onChange: (weightVal) {
                            _weight = weightVal;
                          },
                          title: "Weight(Kg)",
                          initValue: 50,
                          min: 0,
                          max: 300)
                    ],
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SwipeableButtonView(
                  isFinished: _isFinished,
                  onFinish: () async {
                    await Navigator.push(
                        context,
                        PageTransition(
                            child: ScoreScreen(
                              bmiScore: _bmiScore,
                              age: _age,
                            ),
                            type: PageTransitionType.fade));

                    setState(() {
                      _isFinished = false;
                    });
                  },
                  onWaitingProcess: () {
                    //Calculate BMI here
                    calculateBmi();

                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        _isFinished = true;
                      });
                    });
                  },
                  activeColor: Color.fromARGB(255, 31, 117, 255),
                  buttonWidget: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color.fromARGB(255, 243, 3, 3),
                  ),
                  buttonText: "CALCULATE",
                ),
              )
            ],
          ),
        ));
  }

  void calculateBmi() {
    _bmiScore = _weight / pow(_height / 100, 2);
  }
}
