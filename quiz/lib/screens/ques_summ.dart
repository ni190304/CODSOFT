import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'result.dart';

TextStyle _getTextStyle2() {
  return GoogleFonts.katibeh(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 28,
    ),
  );
}

void incj() {
  int j = 0;
  j++;
}

class QuesSumm extends StatelessWidget {
  const QuesSumm(this.summarydata, {super.key});

  final List<Map<String, Object>> summarydata;

  @override
  Widget build(BuildContext context) {
    var j = 0;

    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: summarydata.map((data) {
                return Row(
                  children: [
                    CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 24, 216, 230),
                        child: Text(
                          ((data['question_index'] as int) + 1).toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                        )),
                    const SizedBox(
                      width: 35,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            data['question'] as String,
                            style: _getTextStyle2(),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            data['user_answered'] as String,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 176, 33, 23),
                                fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            data['correct_answer'] as String,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 4, 95, 7),
                                fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }).toList(),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
