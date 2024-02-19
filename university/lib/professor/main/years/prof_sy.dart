import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Prof_Second_Year extends StatefulWidget {
  const Prof_Second_Year({super.key, required this.syclasses_subj});

  final Map<String, List<String>> syclasses_subj; // Change the type here

  @override
  State<Prof_Second_Year> createState() => _Prof_Second_YearState();
}

class _Prof_Second_YearState extends State<Prof_Second_Year> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.syclasses_subj.length,
              itemBuilder: (BuildContext context, int index1) {
                final current_class =
                    widget.syclasses_subj.keys.elementAt(index1);
                final subjects = widget.syclasses_subj.values.elementAt(index1)
                    as List<String>;
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: subjects.length,
                    itemBuilder: (BuildContext context, int index2) {
                      final current_subj = subjects[index2];

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
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                current_subj,
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.brown),
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
