import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/bar_graph/bar_graph.dart';
import 'package:quiz/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

TextStyle _getTextStyle1() {
  return GoogleFonts.katibeh(
    textStyle: const TextStyle(
      color: Colors.brown,
      fontSize: 35,
    ),
  );
}

class Analysis extends StatefulWidget {
  const Analysis({Key? key}) : super(key: key);

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  List<double?> performanceData = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0];
  SharedPreferences? _prefs;
  String? email;

  @override
void initState() {
  super.initState();
  email = FirebaseAuth.instance.currentUser!.email;
  SharedPreferences.getInstance().then((prefs) {
    setState(() {
      _prefs = prefs;
      performanceData = List.generate(
        topics.length,
        (index) {
          final eval = _prefs!.getDouble('$email/${topics[index]}/eval');
          return eval ?? 0.0; // Provide a default value of 0.0 if eval is null
        },
      );
      print(performanceData);
    });
  });
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text('Your Performance Analysis', style: _getTextStyle1(),),
            SizedBox(height: 20,),
            SizedBox(
              height: 400,
              child: MyBarGraph(scores: performanceData),
            ),
          ],
        ),
      ),
    );
  }
}
