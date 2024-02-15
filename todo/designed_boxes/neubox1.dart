import 'package:flutter/material.dart';

class NeuBox1 extends StatelessWidget {
  final child;
  const NeuBox1({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: child,
      ),
      height: 335,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 13,
                offset: Offset(5, 5)),
            const BoxShadow(
                color: Colors.white, blurRadius: 10, offset: Offset(-5, -5))
          ]),
    );
  }
}
