import 'package:flutter/material.dart';

class Neubox7 extends StatelessWidget {
  final child;
  const Neubox7({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: child,
      ),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 236, 233, 233),
          borderRadius: BorderRadius.circular(12),
          ),
    );
  }
}
