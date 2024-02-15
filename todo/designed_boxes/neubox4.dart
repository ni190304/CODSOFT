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
      height: 125,
      width: 300,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 241, 241),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 2,
                offset: Offset(5, 5)),
            const BoxShadow(
                color: Colors.white, blurRadius: 2, offset: Offset(-5, -5))
          ]),
    );
  }
}
