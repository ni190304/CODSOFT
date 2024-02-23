import 'package:flutter/material.dart';

class Neubox4 extends StatelessWidget {
  final child;
  const Neubox4({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Center(
        child: child,
      ),
      height: 105,
      width: 300,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 245, 242, 242),
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
