import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz/screens/home.dart';
import 'package:quiz/screens/ques_scr.dart';
import 'package:quiz/screens/ques_summ.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../info/ques_ans.dart';

TextStyle _getTextStyle1() {
  return GoogleFonts.cardo(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 63, 20, 3),
      fontSize: 23,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle _getTextStyle2() {
  return GoogleFonts.katibeh(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 30,
    ),
  );
}

class Result extends StatefulWidget {
  Result(
      {required this.questions,
      required this.answers,
      super.key,
      required this.ques,
      required this.ans,
      required this.top});

  List<List<QuizQuestion>> questions;
  List<List<String>> answers;
  List<QuizQuestion> ques;
  List<String> ans;
  String? top;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  SharedPreferences? _prefs;
  double? marks;
  double? total_marks;
  double? final_marks;
  String? email;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < answered_ques.length; i++) {
      summary.add({
        'question_index': i,
        'question': widget.ques[i].text,
        'user_answered': answered_ques[i],
        'correct_answer': widget.ans[i],
      });
    }

    return summary;
  }

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
  }

  void saveData() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      marks = _prefs!.getDouble('$email/${widget.top}/eval') ?? 0;
      final double answeredLength = correctly_answered.length.toDouble();
      total_marks = marks! + answeredLength;
      final_marks = (total_marks! / 2);
      _prefs!.setDouble('$email/${widget.top}/eval', final_marks!);
    });
    answered_ques.clear();
    correctly_answered.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SizedBox(
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: correctly_answered.isEmpty
                        ? Lottie.asset('lib/animations/anim2.json')
                        : correctly_answered.length != 0 &&
                                correctly_answered.length <= 3
                            ? Lottie.asset('lib/animations/anim4.json')
                            : correctly_answered.length > 3 &&
                                    correctly_answered.length != 6
                                ? Lottie.asset('lib/animations/anim1.json')
                                : Lottie.asset('lib/animations/anim3.json'),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Your Score : ${correctly_answered.length} / ${answered_ques.length}',
                          style: _getTextStyle1(),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          correctly_answered.isEmpty
                              ? 'Sorry, Better luck next time'
                              : correctly_answered.length <= 3 &&
                                      correctly_answered.isNotEmpty
                                  ? 'Improvement needed'
                                  : correctly_answered.length > 3 &&
                                          correctly_answered.length != 6
                                      ? 'Well done'
                                      : 'Congratulations!!!',
                          style: _getTextStyle1(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              QuesSumm(getSummaryData()),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: OutlinedButton.icon(
                  onPressed: () {
                    saveData();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return Questions_Screen(
                        answers: widget.answers,
                        questions: widget.questions,
                        top: widget.top,
                      );
                    }));
                  },
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      side: const BorderSide(
                        width: 1.0,
                        color: Colors.black,
                      ),
                      backgroundColor: const Color.fromARGB(255, 29, 3, 3)),
                  icon: const Icon(Icons.restart_alt_outlined),
                  label: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, right: 10.0, left: 10.0),
                    child: Text(
                      'Restart Quiz',
                      textAlign: TextAlign.center,
                      style: _getTextStyle2(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton.icon(
                onPressed: () {
                  saveData();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Home();
                  }));
                },
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    side: const BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                    backgroundColor: const Color.fromARGB(255, 29, 3, 3)),
                icon: const Icon(Icons.home),
                label: Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                  child: Text(
                    'Return to HomePage',
                    textAlign: TextAlign.center,
                    style: _getTextStyle2(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
