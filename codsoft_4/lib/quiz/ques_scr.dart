import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/info/ques_ans.dart';
import 'package:quiz/quiz/result.dart';

import 'answer_button.dart';

TextStyle _getTextStyle2() {
  return GoogleFonts.katibeh(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 30,
    ),
  );
}

class Questions_Screen extends StatefulWidget {
  Questions_Screen(
      {super.key,
      required this.questions,
      required this.answers,
      required this.top});

  List<List<QuizQuestion>> questions;
  List<List<String>> answers;
  String? top;

  @override
  State<Questions_Screen> createState() => _Questions_ScreenState();
}

class _Questions_ScreenState extends State<Questions_Screen> {
  var current_question_index = 0;
  int randomIndex = 0;

  @override
  void initState() {
    randomIndex = Random().nextInt(5);
    super.initState();
  }

  void nextquestion() {
    setState(() {
      current_question_index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final current_set = widget.questions[randomIndex];
    final current_question = current_set[current_question_index];
    final current_answer_set = widget.answers[randomIndex];

    return Scaffold(
      backgroundColor: Color.fromARGB(248, 198, 246, 232),
      body: SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                current_question.text,
                style: _getTextStyle2(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              ...current_question.getshuffledanswers().map((answer) {
                return AnswerButton(
                    answertext: answer,
                    ontap: () {
                      answered_ques.add(answer);
                      // ignore: iterable_contains_unrelated_type
                      if (current_answer_set.contains(answer)) {
                        correctly_answered.add(answer);
                      }
                      if (current_question_index == 4) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Result(
                            ques: current_set,
                            ans: current_answer_set,
                            answers: widget.answers,
                            questions: widget.questions,
                            top: widget.top,
                          );
                        }));
                      } else {
                        nextquestion();
                      }
                    });
              })
            ],
          ),
        ),
      ),
    );
  }
}
