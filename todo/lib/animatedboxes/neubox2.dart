import 'package:flutter/material.dart';

class Neubox2 extends StatelessWidget {
  final child;
  const Neubox2({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: child,
      ),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 10,
                offset: Offset(5, 5)),
            const BoxShadow(
                color: Colors.white, blurRadius: 10, offset: Offset(-5, -5))
          ]),
    );
  }
}
