import 'package:flutter/material.dart';

class Neubox4 extends StatelessWidget {
  final child;
  const Neubox4({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Center(
        child: child,
      ),
      height: 450,
      width: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black,
          width: 0.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 53, 52, 52),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
          BoxShadow(
            color: Colors.white,
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(-5, -5),
          ),
        ],
      ),
    );
  }
}
