import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Prof_First_Year extends StatefulWidget {
  const Prof_First_Year({super.key, required this.fyclasses_subj});

  final Map<String, dynamic> fyclasses_subj;

  @override
  State<Prof_First_Year> createState() => _Prof_First_YearState();
}

class _Prof_First_YearState extends State<Prof_First_Year> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.builder(
              itemCount: widget.fyclasses_subj.length,
              itemBuilder: (BuildContext context, int index1) {
                final current_class = widget.fyclasses_subj[index1].key;
                return ListView.builder(
                    itemCount:
                        (widget.fyclasses_subj[index1].value as List).length,
                    itemBuilder: (BuildContext context, int index2) {
                      final current_subj =
                          widget.fyclasses_subj[index1].value[index2];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                current_class,
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                current_subj,
                                style: const TextStyle(fontSize: 11, color: Colors.brown),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              })
        ],
      ),
    );
  }
}
