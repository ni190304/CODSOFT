import 'package:flutter/material.dart';
import 'package:quiz/start.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const Start();
        },
      ));
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      )),
    );
  }
}
