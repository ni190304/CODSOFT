import 'package:flutter/material.dart';

class Neubox3 extends StatelessWidget {
  final child;
  final void Function() ss;
  const Neubox3({super.key, required this.child, required this.ss});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ss,
      child: Container(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Center(
          child: child,
        ),
        height: 50,
        width: 105,
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 2,
                  offset: Offset(5, 5)),
              const BoxShadow(
                  color: Colors.white, blurRadius: 2, offset: Offset(-5, -5))
            ]),
      ),
    );
  }
}
