import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/animatedboxes/neubox2.dart';
import 'package:quiz/screens/ques_scr.dart';

import '../info/ques_ans.dart';

TextStyle _getTextStyle1() {
  return GoogleFonts.katibeh(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 25,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

List<String> topics = [
  'General Knowledge',
  'Movies & TV',
  'Food & Cuisine',
  'Sports',
  'Music',
  'Science & Tech.'
];

List<Color> _colors = [
  Colors.pink.shade100,
  Colors.purple.shade100,
  Colors.blue.shade100,
  Colors.green.shade100,
  Colors.yellow.shade100,
  Colors.orange.shade100
];

class _HomeState extends State<Home> {
  void nav_ques(String topic) {
    if (topic == 'General Knowledge') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Questions_Screen(
                questions: generalKnowledgeQuestions,
                answers: generalKnowledgeCorrectAnswers,
                top: topic,
              )));
    } else if (topic == 'Movies & TV') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Questions_Screen(
                questions: movieAndTVQuestions,
                answers: movieAndTVAnswers,
                top: topic,
              )));
    } else if (topic == 'Food & Cuisine') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Questions_Screen(
                questions: foodAndCuisineQuestions,
                answers: foodAndCuisineAnswers,
                top: topic,
              )));
    } else if (topic == 'Sports') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Questions_Screen(
                questions: sportsquestions,
                answers: sportsAnswers,
                top: topic,
              )));
    } else if (topic == 'Music') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Questions_Screen(
                questions: musicQuestions,
                answers: musicAnswers,
                top: topic,
              )));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Questions_Screen(
                questions: scienceTechQuestions,
                answers: scienceTechAnswers, top: topic,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: topics.length,
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.25,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => nav_ques(topics[index]),
            child: Neubox2(
              col: _colors[index],
              child: Text(
                topics[index],
                style: _getTextStyle1(),
              ),
            ),
          );
        },
      ),
    );
  }
}
