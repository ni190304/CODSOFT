import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ANALYSIS'),
      ),
    );
  }
}