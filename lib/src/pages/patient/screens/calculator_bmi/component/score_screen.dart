import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ScoreScreen extends StatelessWidget {
  final double bmiScore;

  final int age;

  String? bmiStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;

  ScoreScreen({Key? key, required this.bmiScore, required this.age})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    setBmiInterpretation();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 251, 251),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            'BMI Score',
            style: TextStyle(color: Colors.black),
          )),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Your Score",
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            PrettyGauge(
              gaugeSize: 300,
              minValue: 0,
              maxValue: 40,
              segments: [
                GaugeSegment(
                    'UnderWeight', 18.5, Color.fromARGB(255, 191, 234, 245)),
                GaugeSegment('Normal', 6.4, Color.fromARGB(255, 14, 230, 21)),
                GaugeSegment(
                    'OverWeight', 5, Color.fromARGB(255, 242, 219, 14)),
                GaugeSegment('Obese', 10.1, Colors.orange),
              ],
              valueWidget: Text(
                bmiScore.toStringAsFixed(1),
                style: const TextStyle(fontSize: 40),
              ),
              currentValue: bmiScore.toDouble(),
              needleColor: Color.fromARGB(255, 244, 32, 180),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              bmiStatus!,
              style: TextStyle(fontSize: 20, color: bmiStatusColor!),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              bmiInterpretation!,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Re-calculate")),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Share.share(
                          "Your BMI is ${bmiScore.toStringAsFixed(1)} at age $age");
                    },
                    child: const Text("Share")),
              ],
            )
          ])),
    );
  }

  void setBmiInterpretation() {
    if (bmiScore > 30) {
      bmiStatus = "Obese";
      bmiInterpretation = "Please work to reduce obesity";
      bmiStatusColor = Colors.orange;
    } else if (bmiScore >= 25) {
      bmiStatus = "Overweight";
      bmiInterpretation = "Do regular exercise & reduce the weight";
      bmiStatusColor = Color.fromARGB(255, 242, 219, 14);
    } else if (bmiScore >= 18.5) {
      bmiStatus = "Normal";
      bmiInterpretation = "Enjoy, You are fit";
      bmiStatusColor = Color.fromARGB(255, 14, 230, 21);
    } else if (bmiScore < 18.5) {
      bmiStatus = "Underweight";
      bmiInterpretation = "Try to increase the weight";
      bmiStatusColor = Color.fromARGB(255, 5, 68, 83);
    }
  }
}
