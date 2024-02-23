import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(
      {super.key, required this.answertext, required this.ontap});

  final String answertext;

  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 40,
          ),
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 31, 1, 61),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            ),
        child: Text(answertext));
  }
}
