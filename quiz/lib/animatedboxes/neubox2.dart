import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Neubox2 extends StatelessWidget {
  final child;
  Neubox2({super.key, required this.child, required this.col});

  Color? col;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.black, width: 0.25),
              //   color: Theme.of(context).colorScheme.primaryContainer,
              //   borderRadius: BorderRadius.circular(10),
              // ),
      child: Center(
        child: child,
      ),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.1),
                color: col,
          // color: Colors.grey[100],
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
